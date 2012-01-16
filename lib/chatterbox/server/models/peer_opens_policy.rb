require 'set'

module Chatterbox
  class PeerOpensPolicy
    @@Verify = :verify
    @@Accept = :accept

    def self.Verify
      @@Verify
    end

    def self.Accept
      @@Accept
    end

    # takes an array of policies and maps them to the policy
    def self.initialize? policies
      policies.index(@@Verify).nil?
    end

    def self.valid? policy
      valid_keys = Set[:default, :individuals]
      valid_values = Set[@@Verify, @@Accept]
      policy.each_pair do |key, value|
        return false if not valid_keys.member? key
        return false if not valid_values.member? value
      end
      true
    end
  end

  class InvalidPeerOpensPolicy
  end
end
