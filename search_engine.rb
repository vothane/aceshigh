require 'pry'
require 'lib/aceshigh'

module Aces
  module High
    class SearchEngine 
      include Indexable
      include IndexInformable

      attr_accessor :indexer, :index_informer

      def initialize(index_path)
        @indexer = index(index_path)
        @index_informer = index_info(index_path)
      end
    end
  end
end
