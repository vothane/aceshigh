require 'pry'
require 'lib/aceshigh'

class AcesHigh 
  extend Forwardable

  def_delegators :@index, :<<, :clear, :commit, :uncommited, :find, :field_infos

  def initialize(index)
    @index = Lucene::Index.new(index)
  end
end
