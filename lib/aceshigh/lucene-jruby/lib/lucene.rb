require 'logger'
$LUCENE_LOGGER = Logger.new(STDOUT)
$LUCENE_LOGGER.level = Logger::WARN

require_relative 'lucene/config'
require_relative 'lucene/document'
require_relative 'lucene/field_info'
require_relative 'lucene/hits'
require_relative 'lucene/index'
require_relative 'lucene/index_info'
require_relative 'lucene/index_searcher'
require_relative 'lucene/jars/lucene-core-2.9.1'
require_relative 'lucene/query_dsl'
require_relative 'lucene/transaction'