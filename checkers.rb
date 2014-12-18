require_relative 'board'

class Checkers

  attr_accessor :board, :player1, :player2

  def iniialize(player1, player2)
    @player1, @player2 = player1, player2
    @board = board.new
  end
end
