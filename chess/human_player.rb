require_relative 'display.rb'

class HumanPlayer
attr_reader :color, :display

    def initialize(color,display)
        @color=color
        @display=display
    end

    def make_move(board)
        until @display.cursor.selected
            @display.render
            puts "#{color}'s turn. Choose starting position"
        start_pos = @display.cursor.get_input
        end
        until !@display.cursor.selected && @display.cursor.cursor_pos!=start_pos
            @display.render
            puts "Choose ending position"
        end_pos= @display.cursor.get_input
        end
        [start_pos,end_pos]
    end
end