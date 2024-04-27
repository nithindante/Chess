require_relative "Board"
require_relative "Piece"
require_relative "Players"
class Game
  attr_accessor :board

  def initialize()
    @board = Board.new
    @board.setup_board
  end

  # def move(source_cell , destination_cell)
  #   column = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].to_a.index(source_cell.to_s.chars[0])
  #   row = source_cell.to_s.chars[1].to_i
  #   column2 = ["a", "b", "c", "d", "e", "f", "g", "h"].to_a.index(destination_cell.to_s.chars[0])
  #   row2 = destination_cell.to_s.chars[1].to_i
  #   first_diff = column - column2
  #   second_diff = row - row2
  #   arr_diff = [first_diff,second_diff]
  #   my_piece = board.get(source_cell)
  #   if my_piece.edges.include?arr_diff
  #     board.place(destination_cell,my_piece)
  #     board.place(source_cell," ")
  #     return board
  #   else
  #     return "Illegal move, Please try once again"
  #   end
  # end
end

#  b = Board.new
#  b.setup_board
#  g =Game.new
#  g.move(:b8,:a6)
#  g.move(:a6,:b4)
#  g.board.show_board
 #g.move(:a6,:c5).show_board
#b.show_board
