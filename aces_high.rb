require 'pry'
require 'lib/aceshigh'
require_relative './index'

module Aces
  module High
    class SearchEngine 
      include Indexable

      attr_accessor :indexer

      def initialize(index_path)
        @indexer = index(index_path)
      end
    end
  end
end
