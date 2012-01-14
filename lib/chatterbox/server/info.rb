module Chatterbox
  class Info < Goliath::API
    def response(env)
      [200, {}, 'Chatterbox has entered the building']
    end
  end
end
