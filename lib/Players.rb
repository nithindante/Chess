require_relative 'Board'
require_relative 'Piece'

class Players
  attr_accessor :name,:colour

  def initialize(name, colour)
    @name = name
    @colour = colour
  end

end
