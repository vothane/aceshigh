require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "searching" do

  before(:each) do
    @index = Aces::High::Indexable.index('../../test_index')
    @index.field_infos[:value][:type] = Fixnum
    @index << {:id => '1', :name => 'abcdef', :foo => 'bar', :value => 1}
    @index << {:id => '2', :name => 'abcdef', :foo => 'baaz', :value => 2}
    @index << {:id => '3', :name => 'x', :foo => 'bar', :value => 3}
    @index << {:id => '4', :name => ['x', 'y', 'z']}

    @doc1 = @index.uncommited['1']
    @doc2 = @index.uncommited['2']
    @doc3 = @index.uncommited['3']
    @doc4 = @index.uncommited['4']
    @index.commit
  end

  context "when using index find" do

    it "should find a document using a simple dsl query" do
      hits = @index.find { name == 'abcdef' }

      hits.size.should == 2
      hits.should include(@doc1, @doc2)
    end

    it "should find a document using a compound | expression" do
      hits = @index.find { (name == 'abcdef') | (name == 'x') }
      hits.size.should == 4
      hits.should include(@doc1, @doc2, @doc3, @doc4)

      hits = @index.find { (name == 'abcdefx') | (name == 'x') }
      hits.size.should == 2
      hits.should include(@doc3, @doc4)

    end

    it "should find a document using a compound & expression with the same key" do
      hits = @index.find { (name == 'y') & (name == 'x') }
      hits.size.should == 1
      hits.should include(@doc4)

      hits = @index.find { (name == 'y') & (name == 'x') & (name == 'a') }
      hits.size.should == 0
    end

    it "should find with Range" do
      hits = @index.find { value == 2..9 }
      hits.size.should == 2
      hits.should include(@doc2, @doc3)
    end

    it "should find with Range in a compound expression " do
      hits = @index.find { (name == 'abcdef') & (value == 2..9) }
      hits.size.should == 1
      hits.should include(@doc2)
    end


    it "should find with a compound & expression" do
      hits = @index.find { (name == 'abcdef') & (foo == 'bar') }

      hits.size.should == 1
      hits.should include(@doc1)
    end
  end
end