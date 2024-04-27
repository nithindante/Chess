require_relative '../lib/Board'
require_relative '../lib/Piece'
require_relative '../lib/Game'
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
  # it 'Will return error message if a knight cant move from one cordinate to another' do
  #   board = Board.with_setup
  #   expect(board.move(:b2,:b4)).to eq("Illegal move, Please try once again")
  # end

  # it 'Will move a knight from one cordinate to other ' do
  #   board = Board.with_setup
  #   board.move(:b8, :a6)
  #   expect(board.get(:a6).image).to eq(Piece::BlackKnight.new(:black).image)
  # end

  # it ' will return a error message if the source cell is vacant' do
  #   board = Board.with_setup
  #   expect(board.move(:b5,:a5)).to eq("Invalid selection for source cell, Please try once again")
  # end

  # it 'will move a rook from one cordinate to other' do
  #   board = Board.with_setup
  #   board.move(:b1, :a3)
  #   board.move(:a1, :b1)
  #   expect(board.get(:b1).image).to eq(Piece::WhiteRook.new(:white).image)
  # end

  # it " will throw a error message when rook is moved to a alredy occupied cell" do
  #   board = Board.with_setup
  #   expect(board.move(:a1,:a2)).to eq("Illegal move, Please try once again")
  # end

  # it " will throw a error message when there is a obstacle in between" do
  #   board = Board.with_setup
  #   expect(board.move(:a1,:a4)).to eq("Illegal move, Please try once again")
  # end

  # it 'will move a black pawn from one cordinate to other' do
  #   board = Board.with_setup
  #   board.move(:a7, :a6)
  #   expect(board.get(:a6).image).to eq(Piece::BlackPawn.new(:black).image)
  # end

  # it 'will move a white pawn from one cordinate to other' do
  #   board = Board.with_setup
  #   board.move(:a2,:a3)
  #   expect(board.get(:a3).image).to eq(Piece::WhitePawn.new(:white).image)
  # end

  # it 'will get a error message if a black pawn overwrites a white pawn' do
  #   board = Board.with_setup
  #   board.move(:a7, :a6)
  #   board.move(:a2,:a3)
  #   board.move(:a6, :a5)
  #   board.move(:a3,:a4)
  #   expect( board.move(:a5, :a4)).to eq("Illegal move, Please try once again")
  # end

  # it 'will get a error message if a black pawn does a invalid move' do
  #   board = Board.with_setup
  #   board.move(:a7, :a6)
  #   expect( board.move(:a6, :b6)).to eq("Illegal move, Please try once again")
  # end

  # it 'will move a black bishop from one cordinate to another' do
  #   board = Board.with_setup
  #   board.move(:b7, :b6)
  #   board.move(:c8, :a6)
  #   expect(board.get(:a6).image).to eq(Piece::BlackBishop.new(:black).image)
  # end

  # it 'will move a white bishop from one cordinate to another' do
  #   board = Board.with_setup
  #   board.move(:b2, :b3)
  #   board.move(:c1, :a3)
  #   expect(board.get(:a3).image).to eq(Piece::WhiteBishop.new(:white).image)
  # end

  it 'will get a error message if a black bishop does a invalid move' do
    board = Board.with_setup
    expect( board.move(:c1, :b2)).to eq("Illegal move, Please try once again")
  end
end
