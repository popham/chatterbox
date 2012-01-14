require 'goliath'
require 'chatterbox/server/chatterbox_info'
require 'chatterbox/server/chatterbox_websocket'

class ChatterboxDirector < Goliath::API
  get '/chatterbox/', ChatterboxInfo
  map '/chatterbox/0.1/', ChatterboxWebsocket
end
