module Api
  module V1
    class GamesController < ActionController::API
      def show
        game = Game.find_by(id: params[:id])
        if game
          render json: game
        else
          render status: 400
        end
      end

      def create
        challenger = User.find_by(api_key: request.headers['X-Api-Key'])
        opponent = User.find_by(email: params[:opponent_email])
        player_1_board = Board.new(4)
        player_2_board = Board.new(4)
        game_attributes = {
                        player_1_board: player_1_board,
                        player_2_board: player_2_board,
                        player_1_turns: 0,
                        player_2_turns: 0,
                        current_turn: "challenger",
                        challenger: challenger,
                        opponent: opponent
                      }
        game = Game.new(game_attributes)
        if game.save
          render json: game, status: 200
        else
          render status: 400
        end
      end
    end
  end
end
