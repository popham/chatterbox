require 'json'

class ProtocolMessage
  def initialize(version, protocol, payload)
    [@major_version, @minor_version] = version.to_s.split('.', 2)
    @protocol = protocol
    @payload = payload
  end

  # Build a ProtocolMessage instance from a serialized message
  def self.create(message)
    
  end

  # Serialize the a ProtocolMessage instance to a string
  def serialize
    
  end

  private
  attr_accessor :major_version, :minor_version
  attr_accessor :protocol
  attr_accessor :payload

  def version
    @major_version.to_s + @minor_version.to_s
  end
end
