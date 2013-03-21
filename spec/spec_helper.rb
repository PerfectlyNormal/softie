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

class NonDefaultArticle
  include MongoMapper::Document
  plugin Softie

  key :title, String
  softie key: :was_deleted
end

class ArticleWithoutScope
  include MongoMapper::Document
  plugin Softie

  key :title, String
  softie scope: false
end

class User
  include MongoMapper::Document
  key :name
end

class ArticleWithDeletedBy
  include MongoMapper::Document
  plugin Softie

  key :title, String
  softie deleted_by_class: ::User
end

class ArticleWithWasDeletedBy
  include MongoMapper::Document
  plugin Softie

  key :title, String
  softie deleted_by_class: ::User, deleted_by_key: :was_deleted_by
end

RSpec.configure do |config|
  config.before :suite do
    MongoMapper.database.connection.drop_database('softie-spec')
  end
end