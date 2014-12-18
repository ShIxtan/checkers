require 'colorize'

class Player
  attr_reader :name, :board
  attr_accessor :name, :board, :color

  def initialize(name)
    @name = name
    @error = nil
  end
end
