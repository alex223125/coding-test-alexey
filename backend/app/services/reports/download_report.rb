# frozen_string_literal: true

require 'net/http'

module Services
  module Reports
    class DownloadReport
      REPORT_ITEM_CATEGORY = 'NessusReportItem'

      def initialize(report)
        @report = report
        @rd, @wr = IO.pipe
      end

      def call
        read_request
        ActiveRecord::Base.transaction do
          pars_chunks
          close_threads
          mark_as_downloaded
        end
      rescue ActiveRecord::RecordInvalid => e
        message = e.message
        Rails.logger.error(message)
        mark_as_invalid(message)
      end

      private

      def request
        @request = Net::HTTP::Get.new(uri.request_uri)
      end

      def uri
        @uri ||= URI(@report.link)
      end

      def read_request
        @reader_thread = Thread.new do
          Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
            http.request(request) do |response|
              response.read_body do |chunk|
                @wr.write(chunk)
              end
            end
            @wr.close
          end
        end
      end

      def pars_chunks
        reader = Nokogiri::XML::Reader(@rd)
        reader.each do |node|
          next if node.node_type != Nokogiri::XML::Reader::TYPE_ELEMENT

          create_segment(node) if node.name == 'ReportItem'
        end
        @rd.close
      end

      def create_segment(node)
        report_item = Segment.new
        report_item.report = @report
        report_item.category = REPORT_ITEM_CATEGORY
        report_item.content = Nokogiri::XML(node.outer_xml)
        report_item.save!
      end

      def close_threads
        @reader_thread.join
      end

      def mark_as_downloaded
        @report.is_downloaded = true
        @report.is_url_valid = true
        @report.save!
      end

      def mark_as_invalid(message)
        @report.error_reason = message
        @report.is_url_valid = false
        @report.save
      end
    end
  end
end
