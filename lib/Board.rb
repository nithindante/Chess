#require_relative "Game"
require_relative "Piece"
require 'yaml'

class Board
  attr_accessor :arr
  def initialize
    @arr = Array.new(8," ") { Array.new(8," ")}
  end

  def to_yaml
    YAML.dump({
                board: @board
              })
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
    black_pawn = Piece::BlackPawn.new(:Black)
    white_pawn = Piece::WhitePawn.new(:White)
    black_knight = Piece::BlackKnight.new(:Black)
    white_knight = Piece::WhiteKnight.new(:White)
    black_rook = Piece::BlackRook.new(:Black)
    white_rook = Piece::WhiteRook.new(:White)
    black_bishop = Piece::BlackBishop.new(:Black)
    white_bishop = Piece::WhiteBishop.new(:White)
    black_queen = Piece::BlackQueen.new(:White)
    white_queen = Piece::WhiteQueen.new(:White)
    black_king = Piece::BlackKing.new(:Black)
    white_king = Piece::WhiteKing.new(:White)
    place(:a7, black_pawn)
    place(:b7, black_pawn)
    place(:c7, black_pawn)
    place(:d7, black_pawn)
    place(:e7, black_pawn)
    place(:f7, black_pawn)
    place(:g7, black_pawn)
    place(:h7, black_pawn)
    place(:a2, white_pawn)
    place(:b2, white_pawn)
    place(:c2, white_pawn)
    place(:d2, white_pawn)
    place(:e2, white_pawn)
    place(:f2, white_pawn)
    place(:g2, white_pawn)
    place(:h2, white_pawn)
    place(:b8, black_knight)
    place(:g8, black_knight)
    place(:b1, white_knight)
    place(:g1, white_knight)
    place(:a8, black_rook)
    place(:h8, black_rook)
    place(:a1, white_rook)
    place(:h1, white_rook)
    place(:c8, black_bishop)
    place(:f8, black_bishop)
    place(:c1, white_bishop)
    place(:f1, white_bishop)
    place(:d8, black_queen)
    place(:d1, white_queen)
    place(:e8, black_king)
    place(:e1,white_king)
  end

  def place(position,piece)
    column = ["a", "b", "c", "d", "e", "f", "g", "h"].to_a.index(position.to_s.chars[0])
    row = position.to_s.chars[1].to_i
    arr[8 - row][column] = piece
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
    return false unless get(source_cell) == ' '
    true
  end

  def move(source_cell, destination_cell)
    arr_diff = calculate_vertices(source_cell, destination_cell)
    return 'Invalid selection for source cell, Please try once again' if invalid_move?(source_cell)
    return 'Illegal move, Please try once again' unless get(source_cell).valid_edges?(arr_diff)
    return 'Illegal move, Please try once again' if check_pieces_between?(source_cell, destination_cell)
    place(destination_cell, get(source_cell))
    place(source_cell, ' ')
  end

  def check_pieces_between?(source_cell,destination_cell)

    source_piece = get(source_cell).class.to_s.split('::').last
    case source_piece
    when 'BlackRook'
      return true if check_destination_cell_filled("Black",destination_cell)
      check_rook(source_cell, destination_cell)
    when 'WhiteRook'
      return true if check_destination_cell_filled("White", destination_cell)
      check_rook(source_cell, destination_cell)
    when 'BlackPawn'
      return true if check_destination_cell_filled("Black", destination_cell)
      check_pawn("White",source_cell, destination_cell)
    when 'WhitePawn'
      return true if check_destination_cell_filled("White", destination_cell)
      check_pawn("Black",source_cell, destination_cell)
    when 'BlackBishop'
      return true if check_destination_cell_filled("Black", destination_cell)
      check_bishop(source_cell, destination_cell)
    when 'WhiteBishop'
      return true if check_destination_cell_filled("White", destination_cell)
      check_bishop(source_cell, destination_cell)
    when 'BlackKnight'
      true if check_destination_cell_filled("Black", destination_cell)
    when 'WhiteKnight'
      true if check_destination_cell_filled("White", destination_cell)
    when 'BlackQueen'
      return true if check_destination_cell_filled("Black", destination_cell)
      return true if check_bishop(source_cell, destination_cell)
      true if check_rook(source_cell, destination_cell)
    when 'WhiteQueen'
      return true if check_destination_cell_filled('White', destination_cell)
      return true if check_bishop(source_cell, destination_cell)
      true if check_rook(source_cell, destination_cell)
    when 'WhiteKing'
      true if check_destination_cell_filled("White", destination_cell)
    when 'BlackKing'
      true if check_destination_cell_filled("Black", destination_cell)
    end
  end

  def check_destination_cell_filled(color, destination_cell)
    return false unless self.get(destination_cell).class.to_s.split('::').last.include?(color)
    true
  end

  def check_bishop(source_cell, destination_cell)
    if ((column(source_cell) - column(destination_cell)<0) && (row(source_cell) - row(destination_cell)) > 0)
      return check_northeast( source_cell, destination_cell)
    elsif column(source_cell)-column(destination_cell)>0 && row(source_cell) - row(destination_cell)>0
      return check_northwest(source_cell, destination_cell)
    elsif ((column(source_cell) - column(destination_cell)>0) && (row(source_cell) - row(destination_cell)) < 0)
      return check_southwest(source_cell, destination_cell)
    elsif ((column(source_cell) - column(destination_cell)<0) && (row(source_cell) - row(destination_cell)) < 0)
      return check_southeast(source_cell, destination_cell)
    end

    false
  end

  def check_northeast( source_cell, destination_cell)
    range = (row(source_cell) - row(destination_cell))
    for i in 1..range-1
      return true if self.arr[row(source_cell)-i][column(source_cell)+i] != " "
    end
    false
  end



  def check_northwest( source_cell, destination_cell)
    range = (row(source_cell) - row(destination_cell))
    for i in 1..range-1
      return true if self.arr[row(source_cell) - i][column(source_cell) - i] != " "
    end
    false
  end

  def check_southeast(source_cell, destination_cell)
    range = (row(destination_cell) - row(source_cell))
    for i in 1..range-1
      return true if self.arr[row(source_cell) + i][column(source_cell) + i] != " "
    end
    false
  end
  def check_southwest( source_cell, destination_cell)
    range = (row(destination_cell) - row(source_cell))
    for i in 1..range-1
      return true if self.arr[row(source_cell)+i][column(source_cell)-i] != " "
    end
    false
  end

  def check_pawn(color, source_cell, destination_cell)
    if self.get(destination_cell).class.to_s.split('::').last.include?(color)
      if column(destination_cell) - column(source_cell) == 0
        return true
      else
        return false
      end
    elsif self.get(destination_cell).class.to_s.split('::').last == " "
      if column(destination_cell) - column(source_cell) == 0
        return false
      else
        return true
      end
    else
      return false
    end
  end

  def check_rook(source_cell, destination_cell)
    if (column(destination_cell) - column(source_cell)).zero?
      check_columns(source_cell, destination_cell)
    elsif (row(destination_cell) - row(source_cell)).zero?
      check_rows(source_cell, destination_cell)
    end
  end

  def check_columns(source, destination)
    j = column(source)
    if row(source) - row(destination) > 0
      check_arr = (row(source)-1).downto(row(destination)+1).to_a
    else
      check_arr = row(source)+1..(row(destination)-1)
    end
    for i in check_arr do
      return true if self.arr[i][j] != " " # not empty
    end
    false
  end

  def check_rows(source,destination)
    i = row(source)
     if column(source) - column(destination) > 0
       check_arr = ((column(source)-1).downto(column(destination)+1)).to_a
     else
       check_arr = (column(source)+1..column(destination)-1)
     end
    for j in check_arr do
      return true if self.arr[i][j] != " "
    end
    false
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
   8 - cell.to_s.chars[1].to_i
  end

  def check(color)
    sec_color = set_color(color)
    pieces_arr, king_arr, pos_arr, differences_arr, edges_arr = [], [], [], [], []
    arr.each_with_index do |row, i|
       row.each_with_index do |cell, j|
         cell_class = cell.to_s.split('::').last
         if cell_class.include?("#{sec_color}King")
           king_arr.concat([i, j])
         elsif cell_class.include?("#{color}")
           pos_arr.push([i, j])
           pieces_arr.push(cell)
         end
       end
    end

    differences_arr = pos_arr.map do |element|
       [element[0] - king_arr[0], element[1] - king_arr[1]]
    end
    edges_arr = pieces_arr.map(&:edges)
    edges_arr.any? do |edges|
       edges.any? do |vertices|
         differences_arr.include?(vertices) && pos_arr.any? do |pieces|
           desti_cell = cal_position(pieces)
           arr_diff = calculate_vertices(desti_cell, cal_position(king_arr))

           if get(desti_cell).valid_edges?(arr_diff) && !check_pieces_between?(desti_cell, cal_position(king_arr))
            true
           end
         end
       end
    end
   end

  def set_color(color)
    if color == 'White'
      'Black'
    else
      'White'
    end
  end
  def cal_position(vertices)
   row1 = 8 - vertices[0]
   column1 = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].to_a[vertices[1]]
   (column1+row1.to_s).to_sym
  end

  def get_king(sec_color,king_arr)
    arr.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        cell_class = cell.to_s.split('::').last
        if cell_class.include?("#{sec_color}King")

          king_arr.concat([i, j])
        end
      end
    end
    end
  def checkmate(color)
    king_arr=[]
    king= ''
    sum = 0
    second_sum = 0
    sec_color = set_color(color)
    get_king(sec_color, king_arr)
    new_pos = []
    king = self.get(cal_position(king_arr))
    edges_arr =  self.get(cal_position(king_arr)).edges
    edges_arr.each do |edge|
      if edge[0] + king_arr[0] <=7 && edge[1] + king_arr[1] <=7
        new_pos.push([edge[0] + king_arr[0],edge[1] + king_arr[1]])
      end
    end
    new_pos.each do |ele|
      if get(cal_position(ele))== " "
        second_sum += 1
        place(cal_position(ele),king)
        place(cal_position(king_arr)," ")
        if self.check(color) == true
          sum += 1
        end
        place(cal_position(ele)," ")
        place(cal_position(king_arr),king)
      end
    end
    if second_sum!= 0 && sum !=0
      if (second_sum == sum)
        true
      else
        false
      end
    end
  end
end
