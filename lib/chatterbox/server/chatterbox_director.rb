require 'goliath'
require 'server/chatterbox_info'
require 'server/chatterbox_websocket'

class ChatterboxDirector < Goliath::API
  get '/chatterbox/', ChatterboxInfo
  map '/chatterbox/0.1/', ChatterboxWebsocket
end
