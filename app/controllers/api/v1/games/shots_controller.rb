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
            if turn_processor.message == "Invalid coordinates."
              render json: game, status: 400, message: turn_processor.message
            elsif
              if turn_processor.message.include?("Hit")
                game.player_1_board.locate_space(params[:target]).contents.is_sunk?
                render json: game, message: "Your shot resulted in a Hit. Battleship sunk."
              end
            else
              render json: game, message: turn_processor.message
            end
          elsif game.current_turn == "opponent" && player == game.opponent
            turn_processor = TurnProcessor.new(game, params[:shot][:target], player)
            turn_processor.run!
            if turn_processor.message == "Invalid coordinates."
              render json: game, status: 400, message: turn_processor.message
            elsif
              if turn_processor.message.include?("Hit")
                game.player_2_board.locate_space(params[:target]).contents.is_sunk?
                render json: game, message: "Your shot resulted in a Hit. Battleship sunk."
              end
            else
              render json: game, message: turn_processor.message
            end
          else
            render json: game, status: 400, message: "Invalid move. It's your opponent's turn"
          end
        end
      end
    end
  end
end

# game.player_1_board.locate_space(params[:target]).contents.is_sunk?
