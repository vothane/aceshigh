require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "searching" do

  let(:index) { Aces::High::Indexable::LuceneIndex.new }

  context "when using index find" do

    before(:each) do
      index.index( {"name" => 'abcdef', "foo" => 'bar',  "value" => "1"} )
      index.index( {"name" => 'abcdef', "foo" => 'baaz', "value" => "2}"} )
      index.index( {"name" => 'x',      "foo" => 'bar',  "value" => "3"} )
    end

    it "should find a document using a simple dsl query" do
      hits = index.search 'name:abcdef' 

      hits.size.should == 2
      #hits.should include(@doc1, @doc2)
    end
  end 
end