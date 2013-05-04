require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'aceshigh search engine' do

  context "when calling methods on indexer" do

    let(:search_engine) { Aces::High::SearchEngine.new('../../test_index') }
    
    it "should delegate to Lucene index <<" do
      Lucene::Index.any_instance.should_receive(:<<).with( {:id => '69', :content => 'kjbkjkj'} )
      search_engine.indexer.index( {:id => '69', :content => 'kjbkjkj'} )
    end

    it "should delegate to Lucene index clear" do
      Lucene::Index.any_instance.should_receive(:clear)
      search_engine.indexer.clear
    end

    it "should delegate to Lucene index commit" do
      Lucene::Index.any_instance.should_receive(:commit)
      search_engine.indexer.commit
    end

    it "should delegate to Lucene index findt" do
      Lucene::Index.any_instance.should_receive(:find).with( :id => 69 )
      search_engine.indexer.find( :id => 69 )
    end
  end
end