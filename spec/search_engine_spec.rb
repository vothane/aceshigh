require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'aceshigh search engine' do

  let(:search_engine) { Aces::High::SearchEngine.new(index_path: '../../test_index') }

  context "when calling methods on indexer" do
    
    it "should delegate to Lucene index <<" do
      Lucene::Index.any_instance.should_receive(:<<).with( {:id => '69', :content => 'kjbkjkj'} )
      search_engine.index( {:id => '69', :content => 'kjbkjkj'} )
    end

    it "should delegate to Lucene index clear" do
      Lucene::Index.any_instance.should_receive(:clear)
      search_engine.indexer.clear
    end
 
    it "should delegate to Lucene index commit" do
      Lucene::Index.any_instance.should_receive(:commit)
      search_engine.indexer.commit
    end

    it "should delegate to Lucene index find" do
      Lucene::Index.any_instance.should_receive(:find).with( :id => 69 )
      search_engine.indexer.find( :id => 69 )
    end
  end

  context "when calling methods on index_informer" do
    
    it "should delegate to Lucene IndexInfo []" do
      Lucene::IndexInfo.any_instance.should_receive(:[]).with( 69 )
      search_engine.index_informer.info_for_id( 69 )
    end
  end
end