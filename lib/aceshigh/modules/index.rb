module Aces
  module High
    module Indexable

      class LuceneIndex 

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
          hits = @clucy.search(@lucene_index, query, max_results)
          Clojure::Map::clojure_map_to_ruby_array(hits)
        end  

        def delete(query)
          deleted = @clucy.search_and_delete(@lucene_index, query)
        end
      end

    end
  end
end