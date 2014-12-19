require 'colorize'

class Player
  attr_reader :name
  attr_accessor :board, :color

  def initialize(name)
    @name = name
    @error = nil
  end
end
