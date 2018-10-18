class Game < ApplicationRecord
  attr_accessor :messages

  enum current_turn: ["challenger", "opponent"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  belongs_to :challenger, class_name: "User", foreign_key: :challenger_id
  belongs_to :opponent, class_name: "User", foreign_key: :opponent_id

  def player_board
    if current_turn == 'challenger'
      player_2_board
    elsif current_turn == 'opponent'
      player_1_board
    end
  end

  def over?
    winner != nil
  end
end
