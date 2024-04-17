require_relative 'Board'
require_relative 'Game'
require_relative 'Players'
require_relative 'Pawn'

def input_check
  p 'Please enter the color of first person (B/W)'
  input_color = gets.chomp
  unless ['B','W'].include?input_color
    p 'Wrong Selection!,Please enter the correct selection!'
    input_check
  else
    input_color
  end
end

def move_player(i,j,player,pawn,first_input,second_input,chess_board,player_cell,pattern)
  edges_arr = [second_input[0] - first_input[0],second_input[1] - first_input[1]]
  unless pawn.edges.include? edges_arr
    p "Incorrect Position!! Please enter a 2nd valid position"
    input_method(i,j,player,chess_board,player_cell)
    return
  end
  unless chess_board.arr[first_input[0]][first_input[1]].match(pattern)
    p "Incorrect Position!! Please enter a 3rd valid position"
    input_method(i,j,player,chess_board,player_cell)
  else
    chess_board.move(first_input, second_input)
  end
end

def input_method(i,j,player,chess_board,player_cell)
  white_pawn = WhitePawn.new
  black_pawn = BlackPawn.new
  p "Please enter #{player_cell.name}'s source cell"
  first_input = [gets.chomp.to_i, gets.chomp.to_i]
  p "Please enter #{player_cell.name}'s destination cell"
  second_input = [gets.chomp.to_i, gets.chomp.to_i]
  if second_input[0] == i && first_input[0] == j
      chess_board.move(first_input, second_input)
  elsif player.colour == "B"
    move_player(i,j,player,black_pawn,first_input,second_input,chess_board,player_cell,/[\u{2654}-\u{2659}]/)
  elsif player.colour == "W"
    move_player(i,j,player,white_pawn,first_input,second_input,chess_board,player_cell,/[\u{265A}-\u{265F}]/)
  else
    p "Incorrect Position!! Please enter a 1st valid position"
    input_method(i,j,player,chess_board,player_cell)
    return
  end
end

def player_move(chess_board,player_cell)
  case player_cell
  when Player1
    input_method(3,1,Player1,chess_board,player_cell)
  when Player2
    input_method(4,6,Player2,chess_board,player_cell)
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
player_move(chess_board,Player1)
player_move(chess_board,Player2)
chess_board.show_board
player_move(chess_board,Player1)
player_move(chess_board,Player2)
chess_board.show_board
player_move(chess_board,Player1)
chess_board.show_board
