require_relative 'Board'
require_relative 'Game'
require_relative 'Players'
require_relative 'Pawn'

def input_check()
  p 'Please enter the color of first person (B/W)'
   input_color = gets.chomp
   unless ['B','W'].include?input_color
       p 'Wrong Selection!,Please enter the correct selection!'
       input_check()
   else
    input_color
   end
end

def source_check(chess_board,player_cell)
  white_pawn = WhitePawn.new
  black_pawn = BlackPawn.new
  p "Please enter #{player_cell.name}'s source cell"
  first_input = [gets.chomp.to_i, gets.chomp.to_i]
  p "Please enter #{player_cell.name}'s destination cell"
  second_input = [gets.chomp.to_i, gets.chomp.to_i]
  edges_arr = [second_input[0] - first_input[0],second_input[1] - first_input[1]]
  p player_cell
  case player_cell
    when Player1
      if second_input[0]==3
      chess_board.move(first_input, second_input)
      elsif Player1.colour == "B"
        unless black_pawn.edges.include? edges_arr
          p "Incorrect Position!! Please enter a valid position"
          source_check(chess_board,player_cell)
        end
        unless chess_board.arr[first_input[0]][first_input[1]].match(/[\u{2654}-\u{2659}]/)
          p "Incorrect Position!! Please enter a valid position"
          source_check(chess_board,player_cell)
        else
          chess_board.move(first_input, second_input)
        end
      elsif Player1.colour == "W"
        unless white_pawn.edges.include? edges_arr
          p "Incorrect Position!! Please enter a valid  position"
          source_check(chess_board,player_cell)
        end
      unless chess_board.arr[first_input[0]][first_input[1]].match(/[\u{265A}-\u{265F}]/)
        p "Incorrect Position!! Please enter a valid position"
        source_check(chess_board,player_cell)
      else
        chess_board.move(first_input, second_input)
      end
      end
    when Player2
      if second_input[0]==4
        chess_board.move(first_input, second_input)
      elsif Player2.colour == "B"
        unless black_pawn.edges.include? edges_arr
          p "Incorrect Position!! Please enter a valid position"
          source_check(chess_board,player_cell)
        end
        unless chess_board.arr[first_input[0]][first_input[1]].match(/[\u{2654}-\u{2659}]/)
          p "Incorrect Position!! Please enter a valid position"
          source_check(chess_board,player_cell)
        else
          chess_board.move(first_input, second_input)
        end
      elsif Player2.colour == "W"
        unless white_pawn.edges.include? edges_arr
          p "Incorrect Position!! Please enter a valid  position"
          source_check(chess_board,player_cell)
        end
      unless chess_board.arr[first_input[0]][first_input[1]].match(/[\u{265A}-\u{265F}]/)
        p "Incorrect Position!! Please enter a valid position"
        source_check(chess_board,player_cell)
      else
        chess_board.move(first_input, second_input)
      end
      end
  end
end

p 'Please enter the first players name '
Player1 = Players.new(gets.chomp,input_check)
p 'Please enter the second players name'
case Player1.colour
when 'B'
  Player2 = Players.new(gets.chomp, 'W')
when 'W'
  Player2 = Players.new(gets.chomp, 'B')
end
chess_board = Board.new
source_check(chess_board,Player1)
source_check(chess_board,Player2)
chess_board.show_board
# # chess_board.move([6, 1], [5, 1])
# # chess_board.move([2, 0], [3, 0])
# # chess_board.move([5, 1], [4, 1])
# # chess_board.move([3, 0], [4, 1])
# chess_board.show_board
