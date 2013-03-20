$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'timecop'
require 'mongo_mapper'
require 'softie'

MongoMapper.database = 'softie-spec'

class DefaultArticle
  include MongoMapper::Document
  plugin Softie

  key :title, String
  softie
end

RSpec.configure do |config|
  config.before :suite do
    MongoMapper.database.connection.drop_database('softie-spec')
  end
end