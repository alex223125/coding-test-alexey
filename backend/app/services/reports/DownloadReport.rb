module Services
  module Reports
    class DownloadReport

      def initialize(report)
        @report = report
      end

      def call
        download
        attach if @downloaded_file.present?
        mark_as_downloaded if @downloaded_file.present?
        mark_as_invalid if @error_reason.present?
      end

      private

      def download
        @downloaded_file = Down.download(@report.link)
      rescue Down::InvalidUrl => e
        @error_reason = e.message
        Rails.logger.error(@error_reason)
      end

      def attach
        @report.file.attach(io: @downloaded_file, filename: "File attachment for: #{@report.title}")
      end

      def mark_as_downloaded
        @report.is_downloaded = true
        @report.save
      end

      def mark_as_invalid
        @report.error_reason = @error_reason
        @report.is_url_valid = false
        @report.save
      end
    end
  end
end