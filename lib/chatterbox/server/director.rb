require 'goliath'
require 'chatterbox/server/info'
require 'chatterbox/server/websocket'

module Chatterbox
  class Director < Goliath::API
    get '/chatterbox/', Info
    map '/chatterbox/0.1/', Websocket
  end
end
