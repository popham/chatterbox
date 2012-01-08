require 'goliath'
require './chatterbox_info'
require './chatterbox_websocket'

class ChatterboxDirector < Goliath::API
  get '/chatterbox/', ChatterboxInfo
  map '/chatterbox/0.1/', ChatterboxWebsocket
end
