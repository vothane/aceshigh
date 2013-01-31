require 'drb/drb'
require 'lib/aceshigh'

class IndexServer

  def initialize
    directory = Lucene::Store::RAMDirectory.new 
    @indexer  = Lucene::Index::IndexWriter.new(directory, Lucene::Analysis::WhitespaceAnalyzer.new, Lucene::Index::IndexWriter::MaxFieldLength::UNLIMITED) 
  end

  def index(field, value)
    doc = Lucene::Doc::Document.new
    doc.add(Lucene::Doc::Field.new(field, value, Lucene::Doc::Field::Store::YES, Lucene::Doc::Field::Index::NOT_ANALYZED))
    @indexer.add_document(doc)    
  end

  def finalize
    @indexer.close
  end 

end

# [Terminal server with jruby]
# jruby puts00.rb druby://localhost:12345
# druby://localhost:12345

uri = ARGV.shift
DRb.start_service(uri, IndexServer.new)
puts DRb.uri
DRb.thread.join()
