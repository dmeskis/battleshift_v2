module Api
  module V1
    module Games
      class ShipsController < ApiController
        def create
          ship_placer = ShipPlacer.new(board: player_1_board,
                                       ship: sm_ship,
                                       start_space: "A1",
                                       end_space: "A2"
                                      )
          ship_placer.run

        end
      end
    end
  end
end
