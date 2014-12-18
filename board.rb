require_relative 'piece'

class Board

  attr_accessor :grid

  def initialize(empty = false)
    @grid = Array.new(8) { Array.new(8)}

    fill_board unless empty
  end

  def fill_board
    fill_white
    fill_black
  end

  def fill_white
    12.times do |i|
      x = (i * 2) / 8
      y = 1 + ((i * 2) % 8)
      y -= 1 if x.odd?
      pos = [x,y]
      add_piece(pos, :white)
    end
  end

  def fill_black
    12.times do |i|
      x = 5 + ((i * 2) / 8)
      y = (i * 2) % 8
      y -= 1 if x.even?
      pos = [x,y]
      add_piece(pos, :black)
    end
  end

  def render
    grid.each { |row| p row }
    nil
  end

  def on_board?(pos)
    pos.all? {|coor| coord.between?(0,7)}
  end


  def add_piece(pos, color)
    self[pos] = Piece.new(pos, color, self)
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end
end
