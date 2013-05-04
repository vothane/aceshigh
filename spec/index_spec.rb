require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Indexable" do
  before(:each) do
    @index = Aces::High::Indexable.index('../../test_index')
    @index.clear
    @index << {:id => '69', :content => 'kjbkjkj'}
  end

  it "has a to_s method with which says: index path and number of not commited documents" do
    @index.to_s.should == "Index [path: '../../test_index', 1 documents]"
  end

  it "should be empty after clear" do
    @index.clear
    @index.uncommited.size.should == 0
  end

  it "should be empty after commit" do
    @index.commit
    @index.uncommited.size.should == 0
  end

  it "contains one uncommited document" do
    @index.uncommited.size.should == 1
    @index.uncommited['69'][:id].should == '69'
    @index.uncommited['69'][:content].should == 'kjbkjkj'
  end
end