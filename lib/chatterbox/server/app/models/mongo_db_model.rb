require 'em-synchrony'
require 'em-synchrony/em-mongo'
require 'chatterbox/util/protocol_unimplemented'
require 'chatterbox/server/app/models'

class MongoDbModel
  def self.blocking(df)
    EM::Synchrony.sync df
  end

  def self.index db
    raise ProtocolUnimplemented.new __method__
  end

  def self.Connection
    EventMachine.synchrony do
      yield EM::Mongo::Connection.new.db(Chatterbox::Model.db_name)
    end
  end

  def self.drop db
    db.collection(self.collection_name).drop
  end

  private
  def self.collection_name
    raise ProtocolUnimplemented.new __method__
  end
end
