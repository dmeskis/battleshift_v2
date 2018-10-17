require 'rails_helper'

describe 'user can make a shot' do
  describe 'through the api' do
    xit 'sends a payload of target to the endpoint and a shot is made' do
      game = create(:game)
      
      get "#{ENV["ROOT_URL"]}/api/v1/games/#{game.id}/shots?target=D1"
      


    end
  end
end
