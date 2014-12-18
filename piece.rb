class Piece
  attr_accessor :pos, :color, :board, :promoted

  def initialize(pos, color, board, promoted = false)
    @pos = pos
    @color = color
    @board = board
    @promoted = promoted
  end

  def to_s
    color == :black ? "B" : "W"
  end

  def inspect
    color == :black ? "B" : "W"
  end

  def perform_moves!()

  end

  def perform_slide()

  end

  def perform_jump()

  end

  def move_diffs

  end

  def maybe_promote

  end
end
