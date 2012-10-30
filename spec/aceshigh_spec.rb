require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'acceshigh' do

  context "when included" do
    
    it "should included lucene java methods" do
      doc = Lucene::Doc::Document.new

      doc.should be_an_instance_of( Java::OrgApacheLuceneDocument::Document )
    end

  end

end