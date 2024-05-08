require_relative "Board"
require_relative "Piece"
require_relative "Players"
class Game
  attr_accessor :board

  def initialize()
    @board = Board.new
    @board.setup_board
  end
end
