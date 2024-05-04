require_relative "Board"

class Piece
  attr_accessor :colour
  def initialize(color)
    @color = color
  end

  def white?
    @color == :white
  end

  def black?
    !white?
  end

  def valid_edges?(arr_diff)
    arr = edges
    arr.each do |element|
      if element.length == 2 && element == arr_diff
        return true
      elsif element.include? arr_diff
        return true
      end
    end
    false
  end

  class WhitePawn < Piece
    def edges
      [[0, 1]]
    end

    def image
      "\u265F"
    end
  end

  class BlackPawn < Piece
    def edges
      [[0, -1],[-1,-1],[1,-1]]
    end

    def image
      "\u2659"
    end
  end

  class WhiteKnight < Piece
    def edges
      [[-2,-1],[-1,-2],[1,-2],[2,-1],[2,1],[1,2],[-1,2],[-2,1]]
    end

    def image
     "\u265E"
    end
  end

  class BlackKnight < Piece
    def edges
      [[-2,-1],[-1,-2],[1,-2],[2,-1],[2,1],[1,2],[-1,2],[-2,1]]
    end

    def image
      "\u2658"
    end
  end

  class WhiteRook < Piece
    def edges(i = 0, j = 0)
      self_arr = []
      cal_edges(self_arr, -7, 0, :i)
      cal_edges(self_arr, 0, 7, :i)
      i = 0
      j = 0
      cal_edges(self_arr, -7, 0, :j)
      cal_edges(self_arr, 0, 7, :j)
    end

    def cal_edges(self_arr, a, b, loop_var = :i)
      arr = []
      if loop_var == :i
        j = 0
        for i in a..b
          arr.push([i, j])
        end
      elsif loop_var == :j
        i = 0
        for j in a..b
          arr.push([i, j])
        end
      end
      self_arr.push(arr)
      self_arr.sort
    end

    def image
      "\u265C"
    end
  end

  class BlackRook < Piece
    def edges(i = 0, j = 0)
      self_arr = []
      cal_edges(self_arr, -7, 0, :i)
      cal_edges(self_arr, 0, 7, :i)
      i = 0
      j = 0
      cal_edges(self_arr, -7, 0, :j)
      cal_edges(self_arr, 0, 7, :j)
    end

    def cal_edges(self_arr, a, b, loop_var = :i)
      arr = []
      if loop_var == :i
        j = 0
        for i in a..b
          arr.push([i, j])
        end
      elsif loop_var == :j
        i = 0
        for j in a..b
          arr.push([i, j])
        end
      end
      self_arr.push(arr)
      self_arr.sort
    end

    def image
      "\u2656"
    end
  end

  class WhiteBishop < Piece

    def edges
      [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],
      [1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7],
      [-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7],
      [-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]
    ]
    end

    def image
      "\u265D"
    end
  end

  class BlackBishop < Piece
    def edges
      [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],
      [1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7],
      [-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7],
      [-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]]
    end

    def image
      "\u2657"
    end
  end

  class BlackQueen < Piece
    def edges()
      [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],
      [1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7],
      [-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7],
      [-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7],
      [-7,0],[-6,0],[-5,0],[-4,0],[-3,0],[-2,0],[-1,0],[0,0],
      [0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],
      [7,0],[6,0],[5,0],[4,0],[3,0],[2,0],[1,0],[0,0],
      [0,0],[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]
    end
    def image
      "\u2655"
    end
  end

  class WhiteQueen < Piece
    def edges
      [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],
      [1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7],
      [-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7],
      [-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7],
      [-7,0],[-6,0],[-5,0],[-4,0],[-3,0],[-2,0],[-1,0],[0,0],
      [0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],
      [7,0],[6,0],[5,0],[4,0],[3,0],[2,0],[1,0],[0,0],
      [0,0],[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]
    end

    def image
      "\u265B"
    end
  end

  class BlackKing < Piece
    def edges
      [[1,0],[-1,0],[0,1],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]
    end

    def image
      "\u2654"
    end
  end

  class WhiteKing < Piece
    def edges
      [[1,0],[-1,0],[0,1],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]
    end

    def image
      "\u265A"
    end
  end
end
