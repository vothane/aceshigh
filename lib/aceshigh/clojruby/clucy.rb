require 'singleton'
 
class Clucy
  include Singleton
   
  def initialize
    @clucy = ClojureBridge.new
    @clucy._import "clucy.core"
  end 
end
