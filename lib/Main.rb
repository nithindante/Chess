require_relative 'Board'
require_relative 'Piece'
require_relative 'Players'


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

def enter_choices(color,board)
  p 'Please enter the source cell for the move you wish to make'
  source =  gets.chomp.to_sym
  p 'Please enter the destination cell for the move you wish to make'
  destination = gets.chomp.to_sym
  unless board.get(source).to_s.split('::').last.include?"#{color}"
    p "Invalid selection, Please try once again"
    enter_choices(color,board)
  else
    if board.move(source, destination) == "Illegal move, Please try once again"
      p "Invalid selection, Please try once again"
      enter_choices(color,board)
    end
  end
end
p 'Do you want to load the previous saved version (Y/N)'
saved_version = gets.chomp.to_s
if saved_version.downcase=="y"
  demo = YAML.load(File.read("file.yaml"))
  arr = demo[:arr]
  p arr
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
board = Board.with_setup


loop do
  enter_choices("White",board)
  board.show_board
  if board.checkmate("White") == true
    p 'White is the winner'
     break
  elsif board.checkmate("Black") == true
      p 'Black is the winner'
  end
  p " Do you wish to save the game"
  choice = gets.chomp.to_s
  if choice == 'Y'
    demo = board.arr
    File.open("file.yaml","w") do |file|
        file.write(demo.to_yaml)
    end
  end
  enter_choices("Black",board)
 board.show_board
 if board.checkmate("Black") == true
   p 'Black is the winner'
   break
  elsif board.checkmate("White") == true
    p 'White is the winner'
   break
  end
end
