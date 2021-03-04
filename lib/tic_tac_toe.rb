require 'pry'


class TicTacToe
    
    def initialize(board=nil)
        @board = board || Array.new(9," ")
    end

    WIN_COMBINATIONS= [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]    

    def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        conv=input.to_i
        new_index=conv - 1 
        new_index 
    end

    def move(index,token="X")
        @board[index] = token
    end

    def position_taken?(index)
     @board[index] == "X"||@board[index] =="O" ? true : false     
    end

    def valid_move?(index) 
      !position_taken?(index) && index.between?(0,8) ? true : false 
    end

    def turn_count
        count=0
        @board.each do |pos|
            if pos == "X" || pos=="O"
                count +=1
            end
        end
        count 
    end

    def current_player
        turn_count.even? ? "X" : "O"   
    end

    def turn
        puts "Select a position 1-9."
        user_input = gets.chomp
        index= input_to_index(user_input)
        if valid_move?(index) 
            move(index,current_player)
            display_board
        else
            turn 
        end
    end


    def won?
    WIN_COMBINATIONS.any? do|win_combos|
        windex_1= win_combos[0]
        windex_2= win_combos[1]
        windex_3= win_combos[2]
        pos_1=@board[windex_1]
        pos_2=@board[windex_2]
        pos_3=@board[windex_3]
        if pos_1=="X" && pos_2=="X" && pos_3=="X"
            return win_combos
        elsif pos_1=="O" && pos_2=="O" && pos_3=="O"
            return win_combos
        else
          false
        end
      end
    end
    

    def full?
        @board.all?{|pos|pos=="X"||pos=="O"}
    end

    def draw?
        won? ? false : full?
    end
    
#this code passed somehow, but broke the play method. 
    #def over?
     #   draw? == true || won? == true ? true : full?
    #end 
    
    def over?
        if draw?
          return true
        elsif full? && won?
          return true
        elsif won? && !full?
          return true
        else
          return false
        end
      end

    def winner
        if won?
       won?.each{|num| return @board[num]}
        elsif draw?
            nil
        end
    end

    def play 
        until over?
            turn
        end
        if won? 
            puts "Congratulations #{winner}!"
        elsif draw? 
           puts "Cat's Game!"   
        end
    end    
end