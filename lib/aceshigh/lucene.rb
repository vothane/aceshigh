module Lucene

  module Store
    include_package 'org.apache.lucene.store'
  end

  module Index
    include_package 'org.apache.lucene.index'
  end

  module Analysis
    include_package 'org.apache.lucene.analysis'
  end

  module Doc
    include_package 'org.apache.lucene.document'
  end

  module Search
    include_package 'org.apache.lucene.search'
  end

  module TokenAttributes
    include_package 'org.apache.lucene.analysis.tokenattributes'
  end

  StandardTokenizer = org.apache.lucene.analysis.standard.StandardTokenizer
  Version = org.apache.lucene.util.Version

end