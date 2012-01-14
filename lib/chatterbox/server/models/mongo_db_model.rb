require 'em-synchrony'
require 'em-synchrony/em-mongo'

class MongoDbModel
  def self.SyncDb
    db_name = case ENV['Chatterbox']
              when 'test' then 'ChatterboxTesting'
              when 'prod' then 'ChatterboxProduction'
              when 'dev' then 'ChatterboxDevelopment'
              else 'ChatterboxDevelopment'
              end
    yield EM::Mongo::Connection.new.db(db_name)
  end

  def self.AsyncDb
    EventMachine.synchrony do
      SyncDb do |db|
        yield db
      end
    end
  end
end
