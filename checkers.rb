require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Checkers

  attr_reader :board, :player1, :player2

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @board = Board.new
    player1.board = player2.board = board
    player1.color = :red
    player2.color = :blue
  end

  def play
    player = player1
    until board.won?
      begin
        moves = player.turn
        piece = board[moves.first]
        if !piece.nil? && piece.color == player.color
          piece.perform_moves(moves.drop(1))
        else
          raise InvalidMoveError.new "not yours"
        end
      rescue InvalidMoveError => e
        board.message = e.message
        retry
      end
      player = toggle_player(player)
    end

    puts "#{player.name} wins!"
  end

  def toggle_player(player)
    player == player1 ? player2 : player1
  end
end

if $PROGRAM_NAME == __FILE__
  aaron = HumanPlayer.new "Aaron"
  blue = ComputerPlayer.new "Blue"

  game = Checkers.new(aaron, blue)
  game.play
end
