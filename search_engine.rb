require 'pry'
require 'lib/aceshigh'
require 'active_support/core_ext/string/inflections'

module Aces
  module High
    class SearchEngine 
      include Indexable
      include IndexInformable
      include FieldInformable

      attr_accessor :indexer, :index_informer
      
      def initialize(params = {})
        @indexer        = get_index(params[:index_path])
        @index_informer = index_info(params[:index_path])
        @field_informer = field_info(params[:fields] || {})
      end

      def index(data)
        @indexer.index_data( data )
      end 

      def search(query)
        extract_to_hash( @indexer.find(query) )
      end 

      def clear_index
        @indexer.clear
      end 

      def commit_to_index
        @indexer.commit
      end  

      def not_committed
        @indexer.uncommited
      end 

      def store_field(field)
        @indexer.field_infos[field][:store] = true
      end 

      def set_field_type(field, type)
        @indexer.field_infos[field][:type] = (type.to_s).constantize
      end 

      def text_field_analyzer(field, analyzer)
        if (@indexer.field_infos[field][:type] == String) && ([:whitespace, :keyword, :simple].includes? analyzer)
          @indexer.field_infos[field][:analyzer] = analyzer
          @indexer.field_infos[field][:tokenized] = true
        end
      end 

      def remove_from_index(id)
        @indexer.delete(id)
      end 

      def removed_from_index?(id)
        @indexer.deleted?(id)
      end 

      private

      def extract_to_hash(hits)
        results = []
        # unable to do Ruby-esqe iterations on java collection
        hits.size.times do |index|
          results << hits[index].props
        end  
        results
      end  
    end
  end
end
