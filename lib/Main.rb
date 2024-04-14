require_relative 'Board'
require_relative 'Game'
require_relative 'Players'

def input_check()
  p 'Please enter the color of first person'
   input_color = gets.chomp
   unless ['B','W'].include?input_color
       p 'Wrong Selection!,Please enter the correct selection!'
       input_check()
   else
    input_color
   end
end
p 'Please enter the first players name of choice(B/W)'
Player1 = Players.new(gets.chomp,input_check)
p 'Please enter the second players name'
case Player1.colour
when 'B'
  Player2 = Players.new(gets.chomp, 'W')
when 'W'
  Player2 = Players.new(gets.chomp, 'B')
end
chess_board = Board.new


# p "Please enter #{Player1.name}'s source cell"
# first_input = [gets.chomp.to_i, gets.chomp.to_i]
# p "Please enter #{Player1.name}'s destination cell"
# second_input = [gets.chomp.to_i, gets.chomp.to_i]
# if chess_board.arr[first_input[0]][first_input[1]].match(/[\u{2654}-\u{2659}]/)
#   chess_board.move(first_input, second_input)
# end
# p "Please enter #{Player2.name}'s source cell"
# first_input = [gets.chomp.to_i, gets.chomp.to_i]
# p "Please enter #{Player2.name}'s destination cell"
# second_input = [gets.chomp.to_i, gets.chomp.to_i]
# if chess_board.arr[first_input[0]][first_input[1]].match(/[\u{265A}-\u{265F}]/)
#   chess_board.move(first_input, second_input)
# end
#chess_board.show_board
chess_board.move([1, 0], [2, 0])
chess_board.move([6, 1], [5, 1])
chess_board.move([2, 0], [3, 0])
chess_board.move([5, 1], [4, 1])

chess_board.show_board
#chess_board.move([3, 0], [4, 1])
