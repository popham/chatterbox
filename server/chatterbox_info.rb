class ChatterboxInfo < Goliath::API
  def response(env)
    [200, {}, 'Chatterbox has entered the building']
  end
end
