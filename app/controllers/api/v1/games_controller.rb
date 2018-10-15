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
        challenger = User.find(params[:user_id])
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
        game.save
        render json: game
      end
    end
  end
end
