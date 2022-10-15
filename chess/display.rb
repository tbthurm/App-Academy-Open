require 'colorize'
require_relative "cursor.rb"
require_relative 'board.rb'

class Display
    attr_reader :board, :cursor
    def initialize(board)
        @board=board
        @cursor=Cursor.new([0,0],board)
    end

    def back_color(x,y)
        if @cursor.cursor_pos==[x,y] && @cursor.selected
            col=:red
        elsif @cursor.cursor_pos==[x,y]
            col=:yellow
        elsif (x+y).even?
            col=:green
        else
            col=:white
        end
        {background: col}
    end

    def render 
        system('clear')
        puts "Move with arrow keys or WASD"
        puts "Use enter or spacebar to select/unselect piece"
        puts "   0  1  2  3  4  5  6  7"
        (0..7).each do |x| 
            fg=(0..7).map do |y| 
                @board.rows[x][y].to_s.colorize(back_color(x,y))
            end
            puts "#{x}" +" "+ fg.join("")
        
        end
    end
end