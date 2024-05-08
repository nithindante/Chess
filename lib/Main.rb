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
  p board
  p "kundi"
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
 # demo = YAML.load_file('file.yaml', permitted_classes: [Piece::BlackRook])

  demo = YAML.load(File.read("file.yaml"))
  p demo
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
  p board
  p "valiiii"
  if demo!= nil
    arr2= []
    board.arr = demo
    board.arr.each_with_index do |ele,i|
        if board.arr[i] == "\u265F"
          arr2.push(Piece::WhitePawn.new(:White))
        elsif board.arr[i]== "\u2659"
          arr2.push(Piece::BlackPawn.new(:Black))
        elsif board.arr[i] == "\u265E"
          arr2.push(Piece::WhiteKnight.new(:White))
        elsif board.arr[i] == "\u2658"
          arr2.push(Piece::BlackKnight.new(:Black))
        elsif board.arr[i] == "\u265C"
          arr2.push(Piece::WhiteRook.new(:White))
        elsif board.arr[i] == "\u2656"
          arr2.push(Piece::BlackRook.new(:Black))
        elsif board.arr[i] == "\u265D"
          arr2.push(Piece::WhiteBishop.new(:White))
        elsif board.arr[i] == "\u2657"
          arr2.push(Piece::BlackBishop.new(:Black))
        elsif board.arr[i] == "\u2655"
          arr2.push(Piece::BlackQueen.new(:Black))
        elsif board.arr[i] == "\u265B"
          arr2.push(Piece::WhiteQueen.new(:White))
        elsif board.arr[i] == "\u2654"
          arr2.push(Piece::BlackKing.new(:Black))
        elsif board.arr[i] == "\u265A"
          arr2.push(Piece::WhiteKing.new(:Black))
        else
          arr2.push(" ")
        end
      end
      p arr2
      board.arr = arr2
  end

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
    arr2 = []
    board.arr.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if board.arr[i][j]== " "
          arr2.push(" ")
        else
          arr2.push(board.arr[i][j].image)
        end
      end
    end
    #arr2.push(board.arr[0][0])
    File.open("file.yaml","w") do |file|
        file.write(arr2.to_yaml)
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
