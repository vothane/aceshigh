require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Lucene Java library indexing in JRuby' do

  context "when included" do
    
    it "should included Lucene Document class" do
      doc = Lucene::Doc::Document.new

      doc.should be_an_instance_of( Java::OrgApacheLuceneDocument::Document )
    end
    
    it "should included Lucene IndexWriter class" do
      directory = Lucene::Store::RAMDirectory.new
      index = Lucene::Index::IndexWriter.new(directory, Lucene::Analysis::WhitespaceAnalyzer.new, Lucene::Index::IndexWriter::MaxFieldLength::UNLIMITED)
      index.should be_an_instance_of( Java::OrgApacheLuceneIndex::IndexWriter )
    end

  end

  context "when adding documents to an index" do
      
    ids       = ["1", "2"]
    unindexed = ["Netherlands", "Italy"]
    unstored  = ["Amsterdam has lots of bridges", "Venice has lots of canals"]
    text      = ["Amsterdam", "Venice"]
    
    let(:directory) { Lucene::Store::RAMDirectory.new }
    let(:indexer)   { Lucene::Index::IndexWriter.new(directory, Lucene::Analysis::WhitespaceAnalyzer.new, Lucene::Index::IndexWriter::MaxFieldLength::UNLIMITED) }
    
    before(:all) do
      
      ids.each_with_index do |item, index|
        doc = Lucene::Doc::Document.new
        doc.add(Lucene::Doc::Field.new("id", ids[index], Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NOT_ANALYZED))
        doc.add(Lucene::Doc::Field.new("country", unindexed[index], Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NO))
        doc.add(Lucene::Doc::Field.new("contents", unstored[index], Lucene::Doc::Field::Store::NO, Lucene::Doc::Field::Index::ANALYZED))
        doc.add(Lucene::Doc::Field.new("city", text[index], Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::ANALYZED))
        indexer.add_document(doc)    
      end 
       
      indexer.close
       
    end
    
    it "should indexed the data" do
      reader = Lucene::Index::IndexReader.open(directory)
      reader.maxDoc.should == ids.length
      reader.numDocs.should == ids.length
      reader.close
    end
  end

  context "when modifying documents to an index" do
      
    ids       = ["1", "2"]
    unindexed = ["Netherlands", "Italy"]
    unstored  = ["Amsterdam has lots of bridges", "Venice has lots of canals"]
    text      = ["Amsterdam", "Venice"]
    
    let(:directory) { Lucene::Store::RAMDirectory.new }
    let(:indexer)   { Lucene::Index::IndexWriter.new(directory, Lucene::Analysis::WhitespaceAnalyzer.new, Lucene::Index::IndexWriter::MaxFieldLength::UNLIMITED) }
    let(:searcher)  { Lucene::Search::IndexSearcher.new(directory) }
    
    before(:all) do
      
      ids.each_with_index do |item, index|
        doc = Lucene::Doc::Document.new
        doc.add(Lucene::Doc::Field.new("id", ids[index], Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NOT_ANALYZED))
        doc.add(Lucene::Doc::Field.new("country", unindexed[index], Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NO))
        doc.add(Lucene::Doc::Field.new("contents", unstored[index], Lucene::Doc::Field::Store::NO, Lucene::Doc::Field::Index::ANALYZED))
        doc.add(Lucene::Doc::Field.new("city", text[index], Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::ANALYZED))
        indexer.add_document(doc)      
      end 
       
    end
    
    it "should be able to delete indexed data" do
      indexer.delete_documents(Lucene::Index::Term.new("id", "1"))
      indexer.commit
      indexer.has_deletions.should be_true
    end 
    
    it "should be able to update indexed data" do    
      doc = Lucene::Doc::Document.new
      doc.add(Lucene::Doc::Field.new("id", "2", Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NOT_ANALYZED))
      doc.add(Lucene::Doc::Field.new("country", "Netherlands", Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NO))
      doc.add(Lucene::Doc::Field.new("contents", "Den Haag has a lot of museums", Lucene::Doc::Field::Store::NO, Lucene::Doc::Field::Index::ANALYZED))
      doc.add(Lucene::Doc::Field.new("city", "Den Haag", Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::ANALYZED))
      
      indexer.update_document(Lucene::Index::Term.new("id", "1"), doc) 
          
      term = Lucene::Index::Term.new("city", "Den Haag")
      query = Lucene::Search::TermQuery.new(term)
      searcher.search(query, 1).totalHits.should == 1
    end     
  end 
end