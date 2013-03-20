$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'

require 'mongo_mapper'
require 'softie'

MongoMapper.database = 'softie-spec'

def article_class
  klass = Class.new do
    include MongoMapper::Document
    set_collection_name :articles

    key :title, String
  end

  klass.collection.remove
  klass
end

RSpec.configure do |config|
end