module Chatterbox
  class Connection
    @@Open = 1
    @@Uninitialized = 2
    @@Closed = 4

    def initialize user, conversation
      @user = user
      @conversation = conversation
    end

    def open
      
    end

    def close
      
    end

    def post message
      
    end

    def eject user
      
    end

    def invite user
      
    end
  end
end
