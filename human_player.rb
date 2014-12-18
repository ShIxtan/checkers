require_relative 'keypress'
require_relative 'player'

class HumanPlayer < Player
  def turn
    choices = []
    char = nil

    until (char == " " && choices.count > 1 )
      board.render
      char = read_char
      if char == "\r"
        choices << board.cursor
      elsif char == 'q'
        puts
        exit
      else
        move_cursor(char)
      end
    end

    choices
  end

  def move_cursor(char)
    case char
    when "\e[A"
      board.cursor = [board.cursor[0] - 1, board.cursor[1]]
    when "\e[B"
      board.cursor = [board.cursor[0] + 1, board.cursor[1]]
    when "\e[D"
      board.cursor = [board.cursor[0], board.cursor[1] - 1]
    when "\e[C"
      board.cursor = [board.cursor[0], board.cursor[1] + 1]
    end
    [0, 1].each do |i|
      board.cursor[i] = 0 if board.cursor[i] < 0
      board.cursor[i] = 7 if board.cursor[i] > 7
    end
  end
end
