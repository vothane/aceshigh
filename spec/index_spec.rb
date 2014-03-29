require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Indexable with RAM memory" do
  before(:each) do
    @index_ram = Aces::High::Indexable::LuceneIndex.new
  end

  it "have an instance of Clucy" do
    @index_ram.should_not be_nil
  end

  it "should index data hash" do
    @index_ram.index({:name => "Miles", :hobby => "hipstering"})
    @index_ram.index({:name => "Miles", :hobby => "baseball"})

    hits = @index_ram.find("name:miles")
    
    hits.count.should == 2
    hits.should include({"hobby"=>"hipstering"}, {"hobby"=>"baseball"})
  end
end

describe "Indexable with disk memory" do
  before(:each) do
    @index_disk = Aces::High::Indexable::LuceneIndex.new('/temp')
  end

  it "have an instance of Clucy" do
    @index_disk.should_not be_nil
  end
end