require 'chatterbox/server/models/mongo_db_model'
require 'chatterbox/server/models/peer_opens_policy'

module Chatterbox
  class User < MongoDbModel
    private_class_method :new

    =begin Factory Methods =end
    def initialize user
      @user_id = user[:_id]
      @username = user[:username]
      @default_peer_opens_policy = user[:peer_opens_policy][:default]
      @peer_opens_policies = user[:peer_opens_policy][:individuals]
    end

    def self.create(username, options={}, peer_opens_policy={})
      fill_peer_opens_policy peer_opens_policy
      user = {
        username: username,
        peer_opens_policy: peer_opens_policy
      }
      user[:_id] = options[:user_id] if options[:user_id]
      Connection do |db|
        response = db.collection(collection_name).safe_insert(user)
        response.callback do
          return new user
        end
        response.errback do
          puts 'Failed to create a user document.'
          return nil
        end
      end
    end

    def self.load(user_id)
      SyncDb do |db|
        user = blocking db.collection(collection_name).find_one({_id: user_id})
        new user if user
      end
    end
    =begin End of Factory Methods =end
    
    # Implements Protocol from MongoDbModel
    def self.index db
      db.collection(collection_name).create_index(:username, unique: true)
    end

    private
    # Implements Protocol from MongoDbModel
    def self.collection_name
      'users'
    end

    def self.fill_peer_opens_policy policy
      raise InvalidPeerOpensPolicy if not PeerOpensPolicy.valid? policy
      policy[:default] = PeerOpensPolicy.Accept if not policy[:default]
      policy[:individuals] = {} if not policy[:individuals]
      policy
    end
  end
end

=begin Archetypal MongoDb Data Structure:
{
  user_id: [Some ID],
  username: [Some Handle],
  peer_opens_policy:
    {
      default: [Default Policy],
      individuals:
        {
          [Some ID]: [Individual Policy],
          [Some ID]: [Individual Policy],
          ...
        }
    }
}
=end
