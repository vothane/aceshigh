require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Lucene Java library searching in JRuby' do

  context "when searching documents on an index with query" do
      
    ids       = ["1", "2"]
    unindexed = ["Netherlands", "Italy"]
    unstored  = ["Amsterdam  is the largest city and the capital of the Netherlands. It has lots of bridges. Amsterdam is famous for its vibrant and diverse nightlife.", 
                 "Venice has lots of canals. Venice has been the setting or chosen location of numerous films, novels, poems and other cultural references."]
    text      = ["Amsterdam", "Venice"]
    
    let(:directory) { Lucene::Store::RAMDirectory.new }
    let(:indexer)   { Lucene::Index::IndexWriter.new(directory, Lucene::Analysis::WhitespaceAnalyzer.new, Lucene::Index::IndexWriter::MaxFieldLength::UNLIMITED) }
    let(:parser)    { Lucene::Query::QueryParser.new(Lucene::Version::LUCENE_CURRENT, "contents", Lucene::Analysis::WhitespaceAnalyzer.new) }
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
    
    it "should be able to parse query before searching" do  
      query = parser.parse("+canals +bridges -capital")
      searcher.search(query).totalHits.should == 1
      #d = searcher.doc(docs.scoreDocs[0].doc)
      #assertEquals("Ant in Action", d.get("title"))
      #query = parser.parse("mock OR junit")
      #docs = searcher.search(query, 10)
      #assertEquals("Ant in Action, " +"JUnit in Action, Second Edition",2, docs.totalHits)
    end   
  end  
end