require 'drb/drb'
require 'lib/aceshigh'

class AcesHigh

  def initialize
    directory = Lucene::Store::RAMDirectory.new 
    @indexer  = Lucene::Index::IndexWriter.new(directory, Lucene::Analysis::WhitespaceAnalyzer.new, Lucene::Index::IndexWriter::MaxFieldLength::UNLIMITED) 
    @parser    = Lucene::Query::QueryParser.new(Lucene::Version::LUCENE_CURRENT, "contents", Lucene::Analysis::WhitespaceAnalyzer.new) 
    @searcher  = Lucene::Search::IndexSearcher.new(directory) 
  end

  def index(field, value)
    doc = Lucene::Doc::Document.new
    doc.add(Lucene::Doc::Field.new(field, value, Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NOT_ANALYZED))
    @indexer.add_document(doc)    
  end

  def search(query, field)
    results = []
    parsed_query = parser.parse(query)
    query_results = searcher.search(parsed_query)
    query_results.doc.each do |query_result|
      result << query_result.get(field)
    end
  end

  def finalize
    @indexer.close
  end 

end