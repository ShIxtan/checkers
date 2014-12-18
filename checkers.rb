require_relative 'board'
require_relative 'human_player'

class Checkers

  attr_accessor :board, :player1, :player2

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @board = Board.new
    player1.board = player2.board = board
    player1.color = :red
    player2.color = :blue
  end

  def play
    loop do
      begin
        moves = player1.turn
        board[moves.first].perform_moves(moves.drop(1))
      rescue InvalidMoveError
        board.message = "bad move"
        retry
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  aaron = HumanPlayer.new "Aaron"
  blue = HumanPlayer.new "Blue"

  game = Checkers.new(aaron, blue)
  game.play
end
