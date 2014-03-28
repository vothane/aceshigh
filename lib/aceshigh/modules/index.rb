module Aces
  module High
    module Indexable

      extend self

      class LuceneIndex 

        extend Forwardable

        def initialize(index_path=nil)
          clucy = ClojureBridge.new
          clucy._import "clucy.core"
          if (index_path == nil)
            @lucene_index = clucy.memory_index
          else  
            @lucene_index = clucy.disk_index(index_path)
          end   
        end
      end
    end
  end
end