require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'aceshigh search engine' do

  context "when calling methods on indexer" do

    let(:search_engine) { Aces::High::SearchEngine.new('../../test_index') }
    
    it "should delegate to indexer <<" do
      Lucene::Index.any_instance.should_receive(:<<).with( {:id => '69', :content => 'kjbkjkj'} )
      search_engine.indexer.index( {:id => '69', :content => 'kjbkjkj'} )
    end
  end
end