module Aces
  module High
    module Indexable

      extend self

      def index(index_path)
        Index.new(index_path)
      end

      class Index 
        extend Forwardable
        
        def_delegator  :@index, :<<, :index

        def_delegators :@index, :<<, :clear, :commit, :uncommited, :find, :field_infos

        def initialize(index_path)
          @index = Lucene::Index.new(index_path)
        end
      end
    end
  end
end