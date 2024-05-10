require_relative 'Board'
require_relative 'Piece'
require_relative 'Players'


def input_check
  p 'Please enter the color of first person (Black/White)'
  input_color = gets.chomp
  unless ['Black','White'].include?input_color
    p 'Wrong Selection!,Please enter the correct selection!'
    input_check
  else
    input_color
  end
end

def save_game(board,color)
  next_color = color
  new_arr = []
  board.arr.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if board.arr[i][j]== " "
        new_arr.push(" ")
      else
        new_arr.push(board.arr[i][j].image)
      end
    end
  end
  new_arr = new_arr.each_slice(8).to_a
  File.open("file.yaml","w") do |file|
      file.write(new_arr.to_yaml)
      file.write(next_color.to_yaml)
  end
end

def check_mate(board)
  if board.checkmate("White") == true
    p 'White is the winner'
    return true
  elsif board.checkmate("Black") == true
    p 'Black is the winner'
    return false
  end
end

def play_game(board,old_color,newest_color)
  loop do
    enter_choices(old_color,board)
    board.show_board
    return " White is the winner" if check_mate(board) == true
    p " Do you wish to save the game(Y/N)"
    choice = gets.chomp.to_s
    if choice == 'Y'
      save_game(board,newest_color)
    end
    enter_choices(newest_color,board)
    board.show_board
    p " Do you wish to save the game(Y/N)"
    choice = gets.chomp.to_s
    if choice == 'Y'
      save_game(board,old_color)
    end
    return "Black is the winner" if check_mate(board) == false
  end
end

def create_arr(demo,board)
  if demo!= nil
    yaml_arr= []
    board.arr = demo
    board.arr.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if board.arr[i][j] == "\u265F"
          yaml_arr.push(Piece::WhitePawn.new(:White))
              elsif board.arr[i][j]== "\u2659"
                yaml_arr.push(Piece::BlackPawn.new(:Black))
              elsif board.arr[i][j] == "\u265E"
                yaml_arr.push(Piece::WhiteKnight.new(:White))
              elsif board.arr[i][j] == "\u2658"
                yaml_arr.push(Piece::BlackKnight.new(:Black))
              elsif board.arr[i][j] == "\u265C"
                yaml_arr.push(Piece::WhiteRook.new(:White))
              elsif board.arr[i][j] == "\u2656"
                yaml_arr.push(Piece::BlackRook.new(:Black))
              elsif board.arr[i][j] == "\u265D"
                yaml_arr.push(Piece::WhiteBishop.new(:White))
              elsif board.arr[i][j] == "\u2657"
                yaml_arr.push(Piece::BlackBishop.new(:Black))
              elsif board.arr[i][j] == "\u2655"
                yaml_arr.push(Piece::BlackQueen.new(:Black))
              elsif board.arr[i][j] == "\u265B"
                yaml_arr.push(Piece::WhiteQueen.new(:White))
              elsif board.arr[i][j] == "\u2654"
                yaml_arr.push(Piece::BlackKing.new(:Black))
              elsif board.arr[i][j] == "\u265A"
                yaml_arr.push(Piece::WhiteKing.new(:Black))
              else
                yaml_arr.push(" ")
        end
      end
    end 
    board.arr = yaml_arr.each_slice(8).to_a
  end
end

def enter_choices(color,board)
  p "Please enter the source cell for the #{color}'s move you wish to make"
  source =  gets.chomp.to_sym
  p "Please enter the destination cell for #{color}'s the move you wish to make"
  destination = gets.chomp.to_sym
  unless board.get(source).to_s.split('::').last.include?"#{color}"
    p "Invalid selectionss, Please try once again"
    enter_choices(color,board)
  else
    if board.move(source, destination) == "Illegal move, Please try once again"
      p "Invalid selections, Please try once again"
      enter_choices(color,board)
    end
  end
end

newColor = " "
oldColor = " "
board = Board.with_setup
p 'Do you want to load the previous saved version (Y/N)'
saved_version = gets.chomp.to_s
if saved_version.downcase=="y"
  demo = YAML.load(File.read("file.yaml"))
  File.foreach('file.yaml') do |line|
    if line.strip.start_with?("---")
      if line.strip == "--- White"
        newColor = "White"
        oldColor = "Black"
      elsif line.strip == "--- Black"
        newColor = "Black"
        oldColor = "White"
      end
    end
  end
  create_arr(demo,board)
  play_game(board,newColor,oldColor)
end
p 'Please enter the first players name '
Player1 = Players.new(gets.chomp,input_check)
p 'Please enter the second players name'
case Player1.colour
when 'Black'
  Player2 = Players.new(gets.chomp, 'White')
when 'White'
  Player2 = Players.new(gets.chomp, 'Black')
end
old_color = Player1.colour
newest_color = Player2.colour
play_game(board,old_color,newest_color)
 