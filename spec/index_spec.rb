require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Indexable with RAM memory" do
  before(:each) do
    @index = Aces::High::Indexable::LuceneIndex.new
  end

  it "have an instance of Clucy" do
    @index.should_not be_nil
    @index.lucene_index.should be_a( Java::OrgApacheLuceneStore::RAMDirectory )
  end
end