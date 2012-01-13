require 'mongo'
require './peer_opens_policy'

class User
  def initialize(id=nil)
    if id
      @default_peer_opens_policy = 
      @peer_opens_policies = 
    else
      @default_peer_opens_policy = PeerOpensPolicy.Ask
      @peer_opens_policies = Array.new
    end
  end

  #more precise constructors built custom for particular use cases
end
