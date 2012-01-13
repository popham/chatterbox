require 'server/models/mongo_db_model'
require 'server/models/peer_opens_policy'

class User < MongoDbModel
  private_class_method :new

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
    self.users.insert(user, safe: true)
    new user
  end

  def self.load(user_id)
    user = self.users.find_one({_id: user_id})
    if user
      @user_id = user_id
      @username = user[:username]
      @default_peer_opens_policy = user[:peer_opens_policy][:default]
      @peer_opens_policies = user[:peer_opens_policy][:individuals]
    end
  end

  def self.lookup_id(username)
    self.users.find_one({username: username})['_id']
  end

  private
  def self.fill_peer_opens_policy policy
    policy[:default] = PeerOpensPolicy.Accept if not policy[:default]
    policy[:individuals] = {} if not policy[:individuals]
    policy
  end

  def self.users
    get_collection 'users'
  end

  def self.index
    users.create_index(:username, {unique: true})
  end

  def self.drop
    users.drop
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
