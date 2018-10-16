module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])
          player = User.find_by(api_key: api_key)
          turn_processor = TurnProcessor.new(game, params[:shot][:target], player)
          turn_processor.run!
          render json: game, message: turn_processor.message
        end
      end
    end
  end
end
