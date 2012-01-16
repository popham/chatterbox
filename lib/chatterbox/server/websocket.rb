require 'goliath/websocket'

module Chatterbox
  class Websocket < Goliath::WebSocket
    def on_open(env)
      env.logger.info 'Websocket opening...'
      env.handler.send_data('asdf')
    end

    def on_message(env, msg)
      puts 'Websocket Message: ' + msg
    end

    def on_close(env)
      env.logger.info 'Websocket closing...'
    end

    def on_error(env, error)
      env.logger.error error
    end
  end
end
