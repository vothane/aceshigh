module Aces
  module High
    module Indexable

      extend self

      class LuceneIndex 

        extend Forwardable

        def initialize(index_path=nil)
          if index_path
            @lucene_index = Clucy.instance._import("clucy.core").memory_index
          else  
            @lucene_index = Clucy.instance._import("clucy.core").disk_index(index_path)
          end   
        end
      end
    end
  end
end