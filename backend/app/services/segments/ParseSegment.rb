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
      rescue ActiveRecord::RecordInvalid => exception
        message = exception.message
        Rails.logger.error(message)
        mark_as_invalid(message)
      end

      private

      def parser
        Nokogiri::XML::SAX::Parser.new(item_parser)
      end

      def item_parser
        if @segment.category == "NessusReportItem"
          Services::Reports::NessusReportItemParser.new(@segment)
        end
      end

      def mark_as_parsed
        @segment.is_parsed = true
        @segment.save!
      end

      def mark_as_invalid(e)
        @segment.error_reason = e
        @segment.is_parsed = false
        @segment.save
      end
    end
  end
end