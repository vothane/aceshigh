require 'singleton'
 
class Clucy
  include Singleton
   
  def initialize
    clojure_bridge = ClojureBridge.new
    @clucy = clojure_bridge._import "clucy.core"
  end
 
end