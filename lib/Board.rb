require_relative "Game"
require_relative "Pawn"

class Board
  attr_accessor :arr
  def initialize
    @arr = Array.new(8," ") { Array.new(8," ")}
    @arr = set_pieces(@arr)
  end
  def set_pieces(arr)
    arr[0][0]="\u2656"
    arr[0][1]="\u2658"
    arr[0][2]="\u2657"
    arr[0][3]="\u2655"
    arr[0][4]="\u2654"
    arr[0][5]="\u2657"
    arr[0][6]="\u2658"
    arr[0][7]="\u2656"
    arr[7][0]="\u265C"
    arr[7][1]="\u265E"
    arr[7][2]="\u265D"
    arr[7][3]="\u265B"
    arr[7][4]="\u265A"
    arr[7][5]="\u265D"
    arr[7][6]="\u265E"
    arr[7][7]="\u265C"
    arr.each_with_index do |element,index|
      if index == 1
          element.each_with_index do |item,second_index|
            arr[index][second_index]= BlackPawn.new().image
          end
      end
      if index == 6
        element.each_with_index do |item,second_index|
          arr[index][second_index]=WhitePawn.new().image
        end
    end
    end
    return arr
  end

  def show_board
    for i in self.arr
        p i
    end
  end

  def move(i,j,temp=0)
    self_arr = self.arr
    edges_arr = [j[0] - i[0],j[1] - i[1]]
    if self_arr[i[0]][i[1]] == WhitePawn.new().image
      pawn_arr = WhitePawn.new.edges
      if i[0]==6
        pawn_arr.push([-2,0])
        swap_pos(pawn_arr,edges_arr,self_arr,i,j)
      else
      swap_pos(pawn_arr,edges_arr,self_arr,i,j)
      end
    elsif self_arr[i[0]][i[1]] == BlackPawn.new().image
      pawn_arr = BlackPawn.new.edges
      if i[0]==1
        pawn_arr.push([2,0])
        swap_pos(pawn_arr,edges_arr,self_arr,i,j)
      else
      swap_pos(pawn_arr,edges_arr,self_arr,i,j)
      end
    end
  end

  def swap_pos(pawn_arr,edges_arr,self_arr,i,j)
    p edges_arr
    p pawn_arr
    if pawn_arr.include?edges_arr
       p "kundi"
      # p i
      # p j
      temp = self_arr[i[0]][i[1]]
      self_arr[j[0]][j[1]] = temp
      self_arr[i[0]][i[1]] = " "
      p self_arr
      p "fart"
      return self_arr
    end
  end
end
