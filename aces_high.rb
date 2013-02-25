require 'pry'
require 'lib/aceshigh'

class AcesHigh

  def initialize
    @directory = Lucene::Store::RAMDirectory.new 
    @indexer  = Lucene::Index::IndexWriter.new(@directory, Lucene::Analysis::WhitespaceAnalyzer.new, Lucene::Index::IndexWriter::MaxFieldLength::UNLIMITED) 
    @indexer.commit
    @parser    = Lucene::Query::QueryParser.new(Lucene::Version::LUCENE_CURRENT, "contents", Lucene::Analysis::WhitespaceAnalyzer.new) 
    @searcher  = Lucene::Search::IndexSearcher.new(@directory) 
  end

  def index(field, value)
    doc = Lucene::Doc::Document.new
    doc.add(Lucene::Doc::Field.new(field, value, Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NOT_ANALYZED))
    @indexer.add_document(doc)    
  end

  def search(query)
    results = []
    parsed_query = @parser.parse(query)   
    collector = Lucene::Search::TopScoreDocCollector.create(10, true)
    query_results = @searcher.search(parsed_query, collector)
    query_results.doc.each do |query_result|
      results << query_result.get(field)
    end
    results
  end

  def finalize
    @indexer.close
    @directory.close
  end 

end
