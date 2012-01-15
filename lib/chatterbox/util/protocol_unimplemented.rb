class ProtocolUnimplemented
  attr_reader :method_name

  def initialize method_name
    @method_name = method_name
  end
end
