require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'display.rb'

class Game

    def initialize
        @board=Board.new
        @display=Display.new(@board)
        @players={
        white:HumanPlayer.new(:white,@display),
        black:HumanPlayer.new(:black,@display)}
        @current_player=:white
    end

    def play
        until @board.checkmate?(@current_player)
            begin
            @display.render
        positions= @players[@current_player].make_move(@board)
        @board.move_piece(@current_player,positions[0],positions[1])
        swap_turn!
        if !notify_players.nil?
            puts notify_players
            sleep(2)
        end
            rescue StandardError =>e
             puts "Error => "+ e.message
             sleep(1.5)
            end
        end
        puts "#{@current_player} lost"
    end

    private
    def notify_players
        mess=nil
        if @board.in_check?(@current_player)
            mess= "#{@current_player} is in check!"
        end
        mess
    end

    def swap_turn!
        @current_player==:white ? @current_player=:black : @current_player=:white
    end
end

debugger
if $PROGRAM_NAME == __FILE__
    Game.new.play
end