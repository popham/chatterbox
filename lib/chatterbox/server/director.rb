require 'goliath'
require 'chatterbox/server/chatterbox_info'
require 'chatterbox/server/chatterbox_websocket'

module Chatterbox
  class Director < Goliath::API
    get '/chatterbox/', Info
    map '/chatterbox/0.1/', Websocket
  end
end
