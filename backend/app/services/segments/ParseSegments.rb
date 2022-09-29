module Services
  module Segments
    class ParseSegments

      # for more different types of
      # items we can do it using parameters
      # for our purposes we have only one category
      CATEGORY = "NessusReportItem"
      BATCH_SIZE = 500

      def initialize
        @category = CATEGORY
      end

      def call
        segments
        parse
      end

      private

      def segments
        @segments = Segment.all.where(category: @category, is_parsed: false).limit(BATCH_SIZE)
      end

      def parse
        segments.each do |segment|
           Services::Segments::ParseSegment.new(segment).call
        end
      end
    end
  end
end
