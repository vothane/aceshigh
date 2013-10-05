module Aces
  module High
    module Indexable

      extend self

      def get_index(index_path)
        LuceneIndex.new(index_path)
      end

      class LuceneIndex 
        extend Forwardable
        
        def_delegator  :@lucene_index, :<<, :index_data

        def_delegators :@lucene_index, :<<, :clear, :commit, :uncommited, :find, :field_infos, :delete, :deleted?

        def initialize(index_path)
          @lucene_index = Lucene::Index.new(index_path)
        end

        def get_index_path
          @lucene_index.to_s
        end  
      end
    end
  end
end