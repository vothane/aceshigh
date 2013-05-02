require 'pry'
require 'lib/aceshigh'

module Aces
  module high
    class Index 
      extend Forwardable

      def_delegators :@index, :<<, :clear, :commit, :uncommited, :find, :field_infos

      def initialize(index)
        @index = Lucene::Index.new(index)
      end
    end
  end
end
