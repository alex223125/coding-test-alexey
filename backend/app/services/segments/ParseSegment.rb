module Services
  module Segments
    class ParseSegment

      def initialize(segment)
        @segment = segment
      end

      def call
        parser.parse(@segment.content)
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
    end
  end
end