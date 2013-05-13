require 'pry'
require 'lib/aceshigh'

module Aces
  module High
    class SearchEngine 
      extend Forwardable
      include Indexable
      include IndexInformable
      include FieldInformable

      attr_accessor :indexer, :index_informer
      
      #def_delegators :@indexer, :index

      def initialize(params = {})
        @indexer        = index(params[:index_path])
        binding.pry
        @index_informer = index_info(params[:index_path])
        @field_informer = field_info(params[:fields] || {})
      end
    end
  end
end
