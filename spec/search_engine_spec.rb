require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'aceshigh search engine' do

  let(:search_engine) { Aces::High::SearchEngine.new }

  context "when doing actual searching on index" do

    before(:each) do
      search_engine.index( {:id => "9", :name => 'name1', :value => 1, :group => 'a'} )
      search_engine.index( {:id => "10", :name => 'name2', :value => 2, :group => 'a'} )
      search_engine.index( {:id => "11", :name => 'name3', :value => 2, :group => 'b'} )
      search_engine.index( {:id => "12", :name => ['abc', 'def', '123']} )
    end
    
    it "should find stored fields" do
      results = search_engine.search("name:name2")
      results.size.should == 1 
      results.should include( {:id => "10", :name => "name2", :value => 2} )
    end
  end
end