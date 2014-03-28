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
  end
end
