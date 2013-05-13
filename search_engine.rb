require 'pry'
require 'lib/aceshigh'

module Aces
  module High
    class SearchEngine 
      include Indexable
      include IndexInformable
      include FieldInformable

      def initialize(params = {})
        @indexer        = get_index(params[:index_path])
        @index_informer = index_info(params[:index_path])
        @field_informer = field_info(params[:fields] || {})
      end

      def index(data)
        @indexer.index_data( data )
      end 

      def clear_index
        @indexer.clear
      end 

      def commit_to_index
        @indexer.commit
      end  

      def not_commited
        @indexer.uncommited
      end    
    end
  end
end
