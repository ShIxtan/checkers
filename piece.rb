# encoding: utf-8
class InvalidMoveError < StandardError
end

class Piece
  attr_reader :color, :board
  attr_accessor :pos, :promoted

  def initialize(pos, color, board, promoted = false)
    @pos, @color, @board, @promoted = pos, color, board, promoted
  end

  def to_s
    return "\u2B20" if promoted
    "\u2B2D"
  end

  def perform_moves(moves)
    if valid_move_sequence?(moves)
      perform_moves!(moves)
    else
      raise InvalidMoveError.new
    end
    maybe_promote
  end

  def valid_move_sequence?(moves)
    begin
      board.dup[pos].perform_moves!(moves)
    rescue InvalidMoveError
      return false
    end
    true
  end

  def perform_moves!(moves)
    if moves.count == 1
      if perform_slide(moves.first)
      else
        raise InvalidMoveError.new("Invalid") unless perform_jump(moves.first)
      end
    else
      moves.each do |move|
        raise InvalidMoveError.new("Invalid") unless perform_jump(move)
      end
    end
    true
  end

  def perform_slide(move)
    return false unless (Board.on_board?(move) &&
                        board.unoccupied?(move) &&
                        sliding_moves.include?(move))
    board[move], board[pos] = self, nil
    self.pos = move
    true
  end

  def perform_jump(move)
    mid = mid(pos, move)
    return false unless (Board.on_board?(move) &&
                        board.unoccupied?(move) &&
                        (board.occupied?(mid) == enemy_color) &&
                        jumping_moves.include?(move))
    board[move], board[pos] = self, nil
    self.pos = move
    board[mid] = nil
    true
  end

  def enemy_color
    color == :blue ? :red : :blue
  end

  def sliding_moves
    move_diffs.map do |move|
      move[0] += pos[0]
      move[1] += pos[1]
      move
    end
  end

  def jumping_moves
    move_diffs.map do |move|
      move[0] = (move[0] * 2) + pos[0]
      move[1] = (move[1] * 2) + pos[1]
      move
    end
  end

  def mid(from, to)
    mid = []
    mid[0] = (from[0] + to[0])/2
    mid[1] = (from[1] + to[1])/2
    mid
  end

  def move_diffs
    dir = (color == :red ? -1 : 1)
    moves = [[dir, -1], [dir, 1]]
    moves += [[dir * -1, -1],[dir * -1, 1]] if promoted
    moves
  end

  def dup(dup_board)
    self.class.new(pos, color, dup_board, promoted)
  end

  def maybe_promote
    if (color == :red && pos.first == 0) ||
       (color == :blue && pos.first == 7)
      self.promoted = true
    end
  end
end
