module Api
  module V1
    module Games
      class ShipsController < ApiController

        def create
          @game = Game.find(params[:game_id])
          players_board

          if params[:ship_size] == 3
            remaining_ships = 1
            size = 2
            elsif params[:ship_size] == 2
            remaining_ships = 0
          end

          if ship_placer.run && params[:ship_size] == 3
            game = Game.find(params[:game_id])
            render json: game, message: "Successfully placed ship with a size of #{params[:ship_size]}. You have #{remaining_ships} ship(s) to place with a size of #{size}."
          elsif params[:ship_size] == 2
            game = Game.find(params[:game_id])
            render json: game, message: "Successfully placed ship with a size of #{params[:ship_size]}. You have #{remaining_ships} ship(s) to place."
          else
            render status: 400
          end
        end

        private

          def ship_placer
            ShipPlacer.new( board: @board,
                            ship: Ship.new(params[:ship_size]),
                            start_space: params[:start_space],
                            end_space: params[:end_space]
                          )
          end

          def players_board
            if api_key == @game.challenger.api_key
              @board = @game.player_1_board
            elsif api_key == @game.opponent.api_key
              @board = @game.player_2_board
            end
          end
      end
    end
  end
end
