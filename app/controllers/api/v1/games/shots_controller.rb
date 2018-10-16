module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])
          player = User.find_by(api_key: api_key)
          if game.current_turn == "challenger" && player == game.challenger
            turn_processor = TurnProcessor.new(game, params[:shot][:target], player)
            turn_processor.run!
            render json: game, message: turn_processor.message
          elsif game.current_turn == "opponent" && player == game.opponent
            turn_processor = TurnProcessor.new(game, params[:shot][:target], player)
            turn_processor.run!
            render json: game, message: turn_processor.message
          else
            render json: game, status: 400, message: "Invalid move. It's your opponent's turn"
          end
        end
      end
    end
  end
end
