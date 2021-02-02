
require 'pry'
require_relative '../lib/tic_tac_toe'
class TicTacToe


    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize(board= nil)
        @board = board || Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    
    def input_to_index(user_input)
        #puts "Please enter 1-9 :"
        #user_input = gets.chomp
        board_index = user_input.to_i - 1
    end

    def move(user_index,token = "X")
        #board_index = user_index - 1
        @board[user_index] = token
    end

    def position_taken?(index)
        if @board[index] == " "
            false
        else
            true
        end
    end

    def valid_move?(index)
        if (!position_taken?(index) && (0..8).include?(index))
            return true
        else
            return false
        end
    end

    def turn_count
        positions_taken = @board.select{|move| move == "X" || move == "O"}
        positions_taken_size = positions_taken.size
        #turn_count = 9 - vacant_size
    end

    def current_player
         turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        "Please enter 1-9 :"
        user_input = gets.chomp
        #user_index = user_input.to_i
        board_index = input_to_index(user_input)
        if valid_move?(board_index)
            move(board_index,current_player)
            display_board
        else
            "Please enter 1-9 :"
            user_input = gets.chomp
        end
    end

    def won?
         #first first iterate through the WIN_COMBINATIONS constant nested array, then
         # you'll get an array of three digits like [0,4,8]. This numbers are representing the indexis for winning combinations
         # once you get this indices now you need to check if your current board has winning combinations "XXX" or "OOO"
         # at this indices. To do that you simply check if board has same element at each index

        WIN_COMBINATIONS.each do |win_combination| 
            pos1 = win_combination[0]
            pos2 = win_combination[1]
            pos3 = win_combination[2]

            if @board[pos1] == "X" && @board[pos2] == "X" && @board[pos3] == "X" || @board[pos1] == "O" && @board[pos2] == "O" && @board[pos3] == "O"
                return win_combination.flatten
            end
                # @board[win_combination[0]] == @board[win_combination[1]] &&
            #@board[win_combination[1]] == @board[win_combination[2]] 
        end
        # if your detect methods returns a win_combination you return this winning combo
        # else return false
        #your ternary if -else as following:
         
         false

    end

    def full?
        if @board.detect {|vacant| vacant == " "}
            false
        else
            true
        end
    end

    def draw?
        if full? && !won?
            true
        else
            false
        end
    end

    def over?
        draw? || won? ? true : false 
    end

    def winner
        if won? 
            #binding.pry # is [0,4,8]
            index = won?[1]
            @board[index]  #@board[4]
        end
    end

    def play
        until over?
            turn
        end

        if won?
            if winner == "X" || winner == "O"
                puts "Congratulations #{winner}!"
            end
        else draw?
            puts "Cat's Game!"
        end
    end
end
