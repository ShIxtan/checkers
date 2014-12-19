# encoding: utf-8
require_relative 'piece'
require 'colorize'

class Board

  attr_accessor :cursor, :message

  def initialize(empty = false)
    @grid = Array.new(8) { Array.new(8)}
    @cursor = [0,0]
    fill_board unless empty
  end

  def render
    system("clear")
    grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if tile.nil?
          str = "  "
        else
          str = "#{tile} ".colorize(tile.color)
        end
        bg = (((i + j) % 2) == 1 ? :black : :white)
        bg = :green if cursor == [i,j]
        print str.colorize(:background => bg)
      end
      puts
    end
    puts message.colorize(:yellow) if message
    message = nil
  end

  def dup
    dup_board = Board.new(true)

    pieces.each do |piece|
      dup_board[piece.pos] = piece.dup(dup_board)
    end

    dup_board
  end

  def pieces(color = nil)
    pieces = grid.flatten.compact
    if color
      pieces.select { |piece| color == piece.color}
    else
      pieces
    end
  end

  def unoccupied?(pos)
    self[pos].nil?
  end

  def occupied?(pos)
    unoccupied?(pos) ? false : self[pos].color
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def won?
    return :white if pieces.none? { |piece| piece.color == :red }
    return :red if pieces.none? { |piece| piece.color == :blue }
    false
  end

  def self.on_board?(pos)
    pos.all? {|coord| coord.between?(0,7)}
  end    

  private

  attr_reader :grid

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
      add_piece(pos, :blue)
    end
  end

  def fill_black
    12.times do |i|
      x = 5 + ((i * 2) / 8)
      y = (i * 2) % 8
      y -= 1 if x.even?
      pos = [x,y]
      add_piece(pos, :red)
    end
  end

  def add_piece(pos, color)
    self[pos] = Piece.new(pos, color, self)
  end

end
