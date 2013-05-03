module Aces
  module High
    module IndexInformable

      extend self

      def index_info(index_path)
        IndexInfo.new(index_path)
      end

      class IndexInfo
        extend Forwardable
        
        def_delegator  :@index_info, :[], :info_for_id

        def_delegators :@index_info, :id_field, :[]

        def initialize(index_path)
          @index_info = Lucene::IndexInfo.new(index_path)
        end
      end
    end
  end
end