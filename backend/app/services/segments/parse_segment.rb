# frozen_string_literal: true

module Services
  module Segments
    class ParseSegment
      def initialize(segment)
        @segment = segment
      end

      def call
        ActiveRecord::Base.transaction do
          parser.parse(@segment.content)
          mark_as_parsed
        end
      rescue ActiveRecord::RecordInvalid => e
        message = e.message
        Rails.logger.error(message)
        mark_as_invalid(message)
      end

      private

      def parser
        Nokogiri::XML::SAX::Parser.new(item_parser)
      end

      def item_parser
        Services::Reports::NessusReportItemParser.new(@segment) if @segment.category == 'NessusReportItem'
      end

      def mark_as_parsed
        @segment.is_parsed = true
        @segment.save!
      end

      def mark_as_invalid(message)
        @segment.error_reason = message
        @segment.is_parsed = false
        @segment.save
      end
    end
  end
end
