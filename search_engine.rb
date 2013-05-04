require 'pry'
require 'lib/aceshigh'

module Aces
  module High
    class SearchEngine 
      include Indexable
      include IndexInformable

      attr_accessor :indexer, :indexer_info

      def initialize(index_path)
        @indexer = index(index_path)
        @indexer_info = index_info(index_path)
      end
    end
  end
end
