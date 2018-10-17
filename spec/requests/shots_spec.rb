require 'rails_helper'

describe "Api::V1::Shots" do
  before :each do
    @challenger = create(:user)
    @opponent = create(:user)
  end
  context "POST /api/v1/games/:id/shots" do
    let(:player_1_board)   { Board.new(4) }
    let(:player_2_board)   { Board.new(4) }
    let(:sm_ship) { Ship.new(2) }
    let(:game)    {
      create(:game,
        player_1_board: player_1_board,
        player_2_board: player_2_board,
        challenger: @challenger,
        opponent: @opponent
      )
    }

    it "updates the message and board with a hit" do
      allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")
      ShipPlacer.new(board: player_2_board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run

      headers = { "CONTENT_TYPE" => "application/json", "X-Api-Key" => @challenger.api_key}
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Hit."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Hit")
    end

    it "updates the message and board with a miss" do
      allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")

      headers = { "CONTENT_TYPE" => "application/json", "X-Api-Key" => @challenger.api_key}
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Miss."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Miss")
    end

    it "updates the message but not the board with invalid coordinates" do
      player_1_board = Board.new(1)
      player_2_board = Board.new(1)
      game = create(:game,
                    player_1_board: player_1_board,
                    player_2_board: player_2_board,
                    challenger: @challenger,
                    opponent: @opponent
                    )

      headers = { "CONTENT_TYPE" => "application/json", "X-Api-Key" => @challenger.api_key }
      json_payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(game[:message]).to eq "Invalid coordinates."
    end

    it "ends the game when all ships are sunk" do
      allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")
      ShipPlacer.new(board: player_2_board,
                     ship: Ship.new(1),
                     start_space: "A1",
                     end_space: "A1").run

      headers = { "CONTENT_TYPE" => "application/json", "X-Api-Key" => @challenger.api_key}
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Hit. Battleship sunk. Game over."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
    end

    it "user cannot take shot when game is over" do
      allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")
      ShipPlacer.new(board: player_2_board,
                     ship: Ship.new(1),
                     start_space: "A1",
                     end_space: "A1").run

      headers = { "CONTENT_TYPE" => "application/json", "X-Api-Key" => @challenger.api_key}
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      body = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Hit. Battleship sunk. Game over."
      player_2_targeted_space = body[:player_2_board][:rows].first[:data].first[:status]

      expect(body[:message]).to eq expected_messages

      json_payload = {target: "A2"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_success

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:message]).to eq("Invalid move. Game over.")
    end
  end
end
