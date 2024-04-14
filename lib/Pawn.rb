require_relative "Board"

class WhitePawn
  attr_accessor :edges,:image
  def initialize
    @edges = [-1, 0], [-1, -1], [-1, 1]
    @image = "\u265F"
  end
end

class BlackPawn
  attr_accessor :edges,:image
  def initialize
    @edges=[1,0],[1,-1],[1,1]
    @image="\u2659"
  end
end
