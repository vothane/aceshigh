module Aces
  module High
    class IndexWriter
      attr_accessor :index_writer
      def initialize
        @index_writer = org.apache.lucene.IndexWriter.new
      end
    end
  end
end