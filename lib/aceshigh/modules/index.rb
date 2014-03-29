module Aces
  module High
    module Indexable

      extend self

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
          results = []
          hits.each do |hit|
            pair = hit.first
            results << {pair[0].name => pair[1]}
          end       
          results
        end  
      end
    end
  end
end