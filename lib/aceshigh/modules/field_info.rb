module Aces
  module High
    module FieldInformable

      extend self

      def field_info(args = {})
        FieldInfo.new(args)
      end

      class FieldInfo
        extend Forwardable
        
        def_delegators :@field_info, :store?, :[], :convert_to_lucene, :convert_to_ruby

        def initialize(args)
          @field_info = Lucene::FieldInfo.new(args)
        end
      end
    end
  end
end