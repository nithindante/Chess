require_relative "Game"
require_relative "Piece"

class Board
  attr_accessor :arr
  def initialize
    @arr = Array.new(8," ") { Array.new(8," ")}
  end

  def self.with_setup
    board = Board.new
    board.setup_board
    board
  end

  def get(position)
    column = ["a", "b", "c", "d", "e", "f", "g", "h"].to_a.index(position.to_s.chars[0])
    row = position.to_s.chars[1].to_i
    arr[8-row][column]
  end

  def setup_board
    black_pawn = Piece::BlackPawn.new(:black)
    white_pawn = Piece::WhitePawn.new(:white)
    black_knight = Piece::BlackKnight.new(:black)
    white_knight = Piece::WhiteKnight.new(:white)
    black_rook = Piece::BlackRook.new(:black)
    white_rook = Piece::WhiteRook.new(:white)
    black_bishop = Piece::BlackBishop.new(:black)
    white_bishop = Piece::WhiteBishop.new(:white)
    black_queen = Piece::BlackQueen.new(:white)
    white_queen = Piece::WhiteQueen.new(:white)
    black_king = Piece::BlackKing.new(:black)
    white_king = Piece::WhiteKing.new(:white)
    place(:a7,black_pawn)
    place(:b7,black_pawn)
    place(:c7,black_pawn)
    place(:d7,black_pawn)
    place(:e7,black_pawn)
    place(:f7,black_pawn)
    place(:g7,black_pawn)
    place(:h7,black_pawn)
    place(:a2,white_pawn)
    place(:b2,white_pawn)
    place(:c2,white_pawn)
    place(:d2,white_pawn)
    place(:e2,white_pawn)
    place(:f2,white_pawn)
    place(:g2,white_pawn)
    place(:h2,white_pawn)
    place(:b8,black_knight)
    place(:g8,black_knight)
    place(:b1,white_knight)
    place(:g1,white_knight)
    place(:a8,black_rook)
    place(:h8,black_rook)
    place(:a1,white_rook)
    place(:h1,white_rook)
    place(:c8,black_bishop)
    place(:f8,black_bishop)
    place(:c1,white_bishop)
    place(:f1,white_bishop)
    place(:d8,black_queen)
    place(:d1,white_queen)
    place(:e8,black_king)
    place(:e1,white_king)
  end

  def place(position,piece)
    column = ["a", "b", "c", "d", "e", "f", "g", "h"].to_a.index(position.to_s.chars[0])
    row = position.to_s.chars[1].to_i
    arr[8-row][column]= piece
  end

  def show_board
    for i in self.arr
      i.each do |element|
        if element == " "
          print [element]
        else
          print [element.image]
        end
      end
      print "\n"
    end
  end

  def invalid_move?(source_cell)
    if get(source_cell)==" "
      true
    else
      false
    end
  end

  def move(source_cell, destination_cell)
    arr_diff = calculate_vertices(source_cell, destination_cell)
    return 'Invalid selection for source cell, Please try once again' if invalid_move?(source_cell)
    return 'Illegal move, Please try once again' if check_pieces_between?(source_cell, destination_cell)

    if get(source_cell).valid_edges?(arr_diff)
      place(destination_cell, get(source_cell))
      place(source_cell, ' ')
    else
      'Illegal move, Please try once again'
    end
  end



  def check_pieces_between?(source_cell,destination_cell)
    source_piece = get(source_cell).class.to_s.split("::").last
    return false if source_piece.include? 'Knight'

    case source_piece
    when  "BlackRook"
      if column(destination_cell) - column(source_cell) == 1
        return false
      end
      if column(destination_cell) - column(source_cell) == 0
        #j = column(destination_cell)
        check_column(row(source_cell),row(destination_cell))
      elsif row(destination_cell) - row(source_cell) == 0
        i = 8 -row(destination_cell)
        for j in column(source_cell)+1..column(destination_cell)+1
          p arr[i][j]
          return true if arr[i][j] != " "
        end
        false
      end
    when "WhiteRook"
      if column(destination_cell) - column(source_cell) == 1
        return false
      end
      if column(destination_cell) - column(source_cell) == 0
       # j = column(destination_cell)
      check_column(row(source_cell), row(destination_cell))
      elsif row(destination_cell) - row(source_cell) == 0
        i = 8 - row(destination_cell)
        for j in column(source_cell)+1..column(destination_cell)
          return true if arr[i][j] != " "
        end
      end
    end
  end


  def check_column (source,destination)
    arr = (source..destination )
    arr.each do |element|
      if element != ' '
        false
      end
    end
    true
  end
  def calculate_vertices(source_cell, destination_cell)
    source_column = column(source_cell)
    source_row = row(source_cell)
    desti_column = column(destination_cell)
    desti_row = row(destination_cell)
    first_diff = source_column - desti_column
    second_diff = source_row - desti_row
    [first_diff, second_diff]
  end

  def column(cell)
    ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].to_a.index(cell.to_s.chars[0])
  end

  def row(cell)
    cell.to_s.chars[1].to_i
  end
end
