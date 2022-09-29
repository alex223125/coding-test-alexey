# frozen_string_literal: true

module Services
  module Reports
    class DownloadReports
      def call
        process
      end

      private

      def reports
        @reports ||= Report.where(is_downloaded: false, is_url_valid: nil)
      end

      def process
        reports.each do |report|
          Services::Reports::DownloadReport.new(report).call
        end
      end
    end
  end
end
