require 'lib/aceshigh'
require 'active_support/core_ext/string/inflections'

module Aces
  module High

    class SearchEngine 
      include Indexable

      attr_accessor :indexer
      
      def initialize(params = {})
        @indexer = LuceneIndex.new
      end

      def index(data)
        @indexer.index(data)
      end 

      def search(query)
        @indexer.find(query)
      end 

      def clear_index
      end 

      def store_field(field)
      end 

      def set_field_type(field, type)
      end 

      def tokenize_text_field(field)
      end 

      def text_field_analyzer(field, analyzer)
      end

      def remove_from_index(data)
        @indexer.delete(data)
      end 

      def removed_from_index?(id)
      end 

    end
  end
end