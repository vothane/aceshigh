module Clojure
  RT = Java::clojure::lang::RT
  Map = Java::clojure::lang::IPersistentMap

  def self.var(name, ns = "clojure.core")
    RT.var(ns, name)
  end

  module Map

    def self.new(hash)
      clojure = ClojureBridge.new
      hash.inject(Java::clojure::lang::PersistentArrayMap::EMPTY) do |map, pair|
        pair[0] = clojure.keyword(pair[0].to_s)
        map.assoc(*pair)
      end
    end

    def self.clojure_map_to_ruby_array(clojure_map, arr=[])
      clojure_map.inject(arr) do |arr, hit|
        pair = hit.first
        arr << {pair[0].name => pair[1]}
      end 
      arr
    end

  end
end
