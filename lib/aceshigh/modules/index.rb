module Aces
  module High
    module Indexable

      extend self

      class LuceneIndex 

        extend Forwardable
        
        def_delegators :@lucene_index, :add, :search

        attr_accessor :lucene_index, :lucene_index_writer

        def initialize(index_path=nil)
          @clucy = ClojureBridge.new

          @clucy._import "clucy.core"
          if (index_path == nil)
            @lucene_index = @clucy.memory_index
          else  
            @lucene_index = @clucy.disk_index(index_path)
          end   
        end
        
        def index(hash_data)
          @clucy.add(@lucene_index, Clojure::Map::new(hash_data))
        end  

        def find(query, max_results = 10)
          @clucy.search(@lucene_index, query, max_results)
        end  
      end
    end
  end
end