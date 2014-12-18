require 'colorize'

class Player
  attr_accessor :name, :board, :color

  def initialize(name)
    @name = name
    @error = nil
  end

  def toggle_color(color)
    color == :blue ? :red : :blue
  end
end
