class TurnProcessor
  attr_reader :status

  def initialize(game, target, player)
    @game   = game
    @target = target
    @player = player
    @board = game.player_board
    @messages = []
    @status = 200
  end

  def run!
    if player_invalid?
      return
    end
    if is_turn?
      begin
      if @game.over?
        @messages << "Invalid move. Game over."
        @status = 400
        game.save!
        return
      end
      attack_opponent
      if @board.game_over?
        @messages << "Game over."
        @game.winner = @player.email
        game.save!
      end
      game.save!
      rescue InvalidAttack => e
        @messages << e.message
        @status = 400
      end
    else
      @messages << "Invalid move. It's your opponent's turn"
      @status = 400
    end
  end

  def message
    @messages.join(" ")
  end

  private
    attr_reader :game, :target, :player

    def attack_opponent
      result = Shooter.fire!(board: opponent_or_challenger.board, target: target)
      @messages << "Your shot resulted in a #{result}."
      unless @board.locate_space(target).contents == nil then
        if @board.locate_space(target).contents.is_sunk?
          @messages << "Battleship sunk."
        end
      end
      player_turns
    end

    def opponent_or_challenger
      if @player == game.challenger
        Player.new(game.player_2_board)
      elsif @player == game.opponent
        Player.new(game.player_1_board)
      end
    end

    def player_turns
      if @player == game.challenger
        game.player_1_turns += 1
        game.current_turn = 'opponent'
      elsif @player == game.opponent
        game.player_2_turns += 1
        game.current_turn = 'challenger'
      end
    end

    def is_turn?
      if game.current_turn == "challenger" && player == game.challenger
        true
      elsif game.current_turn == "opponent" && player == game.opponent
        true
      else
        false
      end
    end

    def player_invalid?
      if player == nil
        @messages << "Unauthorized"
        @status = 401
      end
    end
end
