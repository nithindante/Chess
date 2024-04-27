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
  it 'Will return error message if a knight cant move from one cordinate to another' do
    board = Board.with_setup
    expect(board.move(:b2,:b4)).to eq("Illegal move, Please try once again")
  end

  it 'Will move a knight from one cordinate to other ' do
    board = Board.with_setup
    board.move(:b2, :a3)
    board.move(:a1, :b1)
    expect(board.get(:b1).image).to eq(Piece::WhiteRook.new(:white).image)
  end

  it ' will return a error message if the source cell is vacant' do
    board = Board.with_setup
    expect(board.move(:b3,:a5)).to eq("Invalid selection for source cell, Please try once again")
  end

  it 'will move a rook from one cordinate to other' do
    board = Board.with_setup
    board.move(:b8, :a6)
    expect(board.move(:a8, :c8)).to eq('Illegal move, Please try once again')
  end

  it " will throw a error message when rook is moved illegaly" do
    board = Board.with_setup
    expect(board.move(:a8,:a4)).to eq("Illegal move, Please try once again")
  end
end
