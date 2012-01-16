require 'chatterbox/server/models/mongo_db_model'
require 'chatterbox/server/models/user'
require 'date'

module Chatterbox
  class Conversation < MongoDbModel
    @@Open = :open
    @@Closed = :closed
    private_class_method :new
    attr_reader :id, :state, :created_at, :initiater_id, :conversants, :messages, :last_touch

    def initialize conversation
      @id = conversation[:_id]
      @state = conversation[:state]
      @created_at = conversation[:created_at]
      @conversants = conversation[:conversants].map { |id| User.load(id) }
      @initiater = @conversants.at(@conversants.index { |c| c.id == conversation[:initiater_id] })
      @messages = conversation[:messages]
      if conversation[:messages].empty
        @last_touch = @created_at
      else
        @last_touch = conversation[:messages].last[:time_stamp]
      end
    end

    def self.create(initiater_id, other_ids)
      conversation = {
        state: @@Open,
        created_at: DateTime.now,
        initiater_id: initiater_id,
        conversants: [initiater_id].concat(other_ids),
        messages: []
      }

      Connection do |db|
        response = db.collection(collection_name).safe_insert(conversation)
        response.callback do
          return new conversation
        end
        response.errback do
          puts 'Failed to create a conversation document.'
          return nil
        end
      end
    end

    def self.load(conversation_id)
      SyncDb do |db|
        conversation = blocking db.collection(collection_name).find_one({_id: conversation_id})
        new conversation if conversation
      end
    end
  end

  class Conversation < MongoDbModel
    def self.index db
      db.collection(collection_name).create_index('conversants')
    end

    private
    def self.collection_name
      'conversations'
    end
  end

  class Conversation < MongoDbModel
    
  end
end
