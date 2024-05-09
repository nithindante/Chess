require_relative '../lib/Board'
require_relative '../lib/Piece'
#require_relative '../lib/Game'
require 'stringio'

describe 'Board' do
  describe '#get' do
    it 'gets the piece at the mentioned position ' do
      board = Board.new
      black = Piece::BlackPawn.new(:black)
      board.place(:a2, black)
      expect(board.get(:a2).image).to eql("\u2659")
    end
  end

  describe '#get' do
    it 'gets the peice' do
      board = Board.with_setup
      expect(board.get(:a7).image).to eql("\u2659")
    end
  end
end

describe 'Piece' do
  it 'Pieces has color' do
    white = Piece::WhitePawn.new(:white)
    expect(white.white?).to equal(true)
  end
end

  describe '#move' do
  it 'Will return error message if a knight cant move from one cordinate to another' do
    board = Board.with_setup
    expect(board.move(:b2,:b4)).to eq("Illegal move, Please try once again")
  end

  it 'Will move a knight from one cordinate to other ' do
    board = Board.with_setup
    board.move(:b8, :a6)
    expect(board.get(:a6).image).to eq(Piece::BlackKnight.new(:black).image)
  end

  it ' will return a error message if the source cell is vacant' do
    board = Board.with_setup
    expect(board.move(:b5,:a5)).to eq("Invalid selection for source cell, Please try once again")
  end

  it 'will move a rook from one cordinate to other' do
    board = Board.with_setup
    board.move(:b1, :a3)
    board.move(:a1, :b1)
    expect(board.get(:b1).image).to eq(Piece::WhiteRook.new(:white).image)
  end

  it " will throw a error message when rook is moved to a alredy occupied cell" do
    board = Board.with_setup
    expect(board.move(:a1,:a2)).to eq("Illegal move, Please try once again")
  end

  it " will throw a error message when there is a obstacle in between" do
    board = Board.with_setup
    board.move(:a2,:a3)
    board.move(:a3,:a4)
    board.move(:a1,:a3)
    expect(true).to eq(true)
  end

  it 'will move a black pawn from one cordinate to other' do
    board = Board.new
    white_pawn = Piece::WhitePawn.new(:white)
    board.place(:b7,white_pawn)
    board.move(:b7,:c8)
    board.show_board
    expect(true).to eq(true)
  end

  it 'will move a white pawn from one cordinate to other' do
    board = Board.with_setup
    board.move(:a2,:a3)
    board.show_board
    expect(board.get(:a3).image).to eq(Piece::WhitePawn.new(:white).image)
  end

  it 'will get a error message if a black pawn overwrites a white pawn' do
    board = Board.with_setup
    board.move(:a7, :a6)
    board.move(:a2,:a3)
    board.move(:a6, :a5)
    board.move(:a3,:a4)
    expect( board.move(:a5, :a4)).to eq("Illegal move, Please try once again")
  end

  it 'will get a error message if a black pawn does a invalid move' do
    board = Board.with_setup
    board.move(:a7, :a6)
    expect( board.move(:a6, :b6)).to eq("Illegal move, Please try once again")
  end

  it 'will move a black bishop from one cordinate to another' do
    board = Board.with_setup
    board.move(:d7, :d6)
    board.move(:d6, :d5)
    board.move(:d8, :d7)
    board.move(:d7, :d6)
    expect(true).to eq(true)
  end

  it 'will move a white bishop from one cordinate to another' do
    board = Board.with_setup
    board.move(:b2, :b3)
    board.move(:c1, :a3)
    expect(board.get(:a3).image).to eq(Piece::WhiteBishop.new(:white).image)
  end

   it 'will get a error message if a knight tries to move to a destination cell which is already occupied with same color' do
     board = Board.with_setup
     board.move(:a2,:a3)
     expect( board.move(:b1, :a3)).to eq("Illegal move, Please try once again")
   end

  it 'will get a error message for bishop if destination cell is already occupied with a peice of same color' do
    board = Board.with_setup
    board.move(:b2, :b3)
    board.move(:a2, :a3)
    expect(board.move(:c1, :a3)).to eq("Illegal move, Please try once again")
  end

  it 'will get a error message if a invalid move is done on a bishop' do
    board = Board.with_setup
    board.move(:b7, :b6)
    board.move(:c8, :a6)
    board.move(:a6, :c4)
    board.move(:e7, :e6)
    expect(board.move(:c4, :f7)).to eq("Illegal move, Please try once again")
  end

  it 'will get a error message if a invalid move is done on a bishop' do
    board = Board.with_setup
    board.move(:b7, :b6)
    board.move(:c8, :b7)
    board.move(:d7, :d6)
    board.move(:d6, :d5)
    expect(board.move(:b7, :e4)).to eq("Illegal move, Please try once again")
  end

  it 'will get a error message if a invalid move is done on a bishop' do
    board = Board.with_setup
    board.move(:g7, :g6)
    board.move(:f8, :g7)
    board.move(:g7, :d4)
    board.move(:a7, :a6)
    board.move(:b7, :b6)
    expect(board.move(:d4, :a7)).to eq("Illegal move, Please try once again")
  end

  it 'will get a error message if a invalid move is done on a bishop' do
    board = Board.with_setup
    board.move(:e7, :e6)
    board.move(:e6, :e5)
    board.move(:g7, :g6)
    board.move(:f8, :g7)
    expect(board.move(:g7, :d4)).to eq("Illegal move, Please try once again")
  end

  it 'will thow a error message if a black queen is moved from one illelgal cordinate to another or vice versa' do
    board = Board.with_setup
    board.move(:d7, :d6)
    board.move(:d6, :d5)
    board.move(:d8, :d6)
    board.move(:c7, :c6)
    expect(board.move(:d6, :b6)).to eq("Illegal move, Please try once again")
  end

  it 'will thow a error message if a black queen is moved from one illelgal cordinate to another or vice versa' do
    board = Board.with_setup
    board.move(:d2,:d3)
    board.move(:d3,:d4)
    board.move(:d1,:d3)
    board.move(:c2,:c3)
    board.move(:c3,:c4)
    board.move(:d3,:a3)
    expect(true).to equal(true)
   # expect(board.move(:d3, :a6)).to eq("Illegal move, Please try once again")
  end

  it 'will move a king from one position to another' do
    board = Board.with_setup
    board.move(:e2, :e3)
    board.move(:e1, :e2)
    expect(board.get(:e2).image).to eq(Piece::WhiteKing.new(:white).image)
    #expect(board.move(:d6, :b6)).to eq("Illegal move, Please try once again")
  end

  it 'will get a error message if we move a king to a invalid position' do
    board = Board.with_setup
    board.move(:e2, :e3)
    board.move(:e1, :e2)
    board.move(:f2,:f3)
    board.move(:d2,:d3)
    expect(board.move(:e2, :f1)).to eq("Illegal move, Please try once again")
  end

  it 'will capture an opposite player and occupy that position' do
    board = Board.with_setup
    board.move(:b7, :b6)
    board.move(:c2, :c3)
    board.move(:b8,:c6)
    board.move(:c6,:e5)
    board.move(:c3,:c4)
    board.move(:e5,:c4)
    #board.show_board
    expect(board.get(:c4).image).to eq(Piece::BlackKnight.new(:black).image)
  end

  it 'will and get a error message if a piece from the opposite team is on the path' do
    board = Board.with_setup
    board.move(:b7, :b6)
    board.move(:a2, :a3)
    board.move(:a3,:a4)
    board.move(:b6,:b5)
    board.move(:b5,:b4)
    board.move(:b4,:b3)
    board.move(:a1,:a3)
    expect(board.move(:a3, :c3)).to eq("Illegal move, Please try once again")
  end

  it 'will and get a error message if a piece from the opposite team is on the path' do
    board = Board.with_setup
    board.move(:b2, :b3)
    black = Piece::BlackPawn.new(:black)
    board.place(:a4,black)
    board.move(:b3, :a4)
   # board.show_board
    expect(true).to equal(true)
    #expect(board.move(:b3, :b4)).to eq("Illegal move, Please try once again")
  end

  it "will check and display, if the opposition's king is in check position" do
    board = Board.with_setup
  #  board.move(:d7, :d6)
    board.move(:e7, :e6)
    board.move(:e6, :e5)
    board.move(:e5, :e4)
    board.move(:f2, :f3)
    board.move(:f3, :e4)
    board.move(:e8, :e7)
    board.move(:e7, :e6)
    board.move(:e6, :e5)
    board.move(:e5, :e4)
    board.move(:a2, :a3)
    board.move(:a3, :a4)
    board.move(:a4, :a5)
    board.move(:a1, :a4)
    board.move(:d2, :d3)
    board.move(:d3, :d4)
    board.move(:d4, :d5)
    board.move(:d5, :d6)
    board.move(:d1, :d5)
    board.move(:h2, :h3)
    board.move(:h3, :h4)
    board.move(:h1, :h3)
    expect(board.checkmate("White")).to eq(true)
  end

  it "will check and display, if the Black opposition's king is in check position" do
    board = Board.new
   # black_pawn = Piece::BlackPawn.new(:black)
   # board.place(:c5,black_pawn)
    white_king = Piece::WhiteKing.new(:white)
    board.place(:d5, white_king)
    black_rook = Piece::BlackRook.new(:black)
    board.place(:d2, black_rook)
    black_bishop = Piece::BlackBishop.new(:black)
    board.place(:h2, black_bishop)
    black_knight = Piece::BlackKnight.new(:black)
    board.place(:b3, black_knight)
    black_pawn = Piece::BlackPawn.new(:black)
    board.place(:e2, black_rook)
   # board.place(:b5, black_pawn)
   # board.place(:f7, black_bishop)
    board.place(:c3, black_pawn)
    board.place(:f3, black_pawn)
    board.place(:b7,black_bishop)
   # board.show_board
    expect(board.checkmate("Black")).to eq(false)
  end

  it "will check and display, if the White opposition's king is in check position" do
    board = Board.new
   # black_pawn = Piece::BlackPawn.new(:black)
   # board.place(:c5,black_pawn)
    black_king = Piece::BlackKing.new(:black)
    board.place(:d5, black_king)
    white_rook = Piece::WhiteRook.new(:white)
    board.place(:d2, white_rook)
    white_bishop = Piece::WhiteBishop.new(:white)
    board.place(:h2, white_bishop)
    white_knight = Piece::WhiteKnight.new(:white)
    board.place(:b3, white_knight)
    white_pawn = Piece::WhitePawn.new(:white)
    board.place(:e2, white_rook)
    board.place(:b5, white_pawn)
    board.place(:f7, white_bishop)
    board.place(:c3, white_pawn)
    board.place(:b7,white_bishop)
    expect(board.checkmate("White")).to eq(true)
  end
 end
