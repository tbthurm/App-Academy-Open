require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'hand.rb'

class Game
    attr_accessor :g_pot, :deck, :players, :current_player, :bet, :winner

    def initialize(names)
        @g_pot=0
        @deck=Deck.new
        @players=names.map{|player| Player.new(player)}
        @current_player=@players[0]
        @winner=[]
    end

    def deal
        @deck.shuffle_cards
        until @players[0].hand.length==5
        @players.each {|py| py.hand<<@deck.cards.pop if py.hand.length<5}
        end
        puts "cards dealt"
    end

    def switch
        @players.each.with_index do |py,i|
            if @current_player == py
                @current_player = @players[(i+1)%players.length]
                break
            end
        end
    end

    def ante
        @players.each do |py|
            py.pot-=5
            @g_pot+=5
        end
        puts "players anted up"
    end

    def bet_round
        loop do
            switch until !@current_player.folded
            puts "#{@current_player.name} what will you do?"
            ans=@current_player.choose

            case ans
            when "f"
                @current_player.folded=true
                @current_player.turn=true
            when "r"
                @current_player.pot-=10
                @g_pot+=10
                @current_player.turn=true
            when "s" 
                @current_player.pot-=5
                @g_pot+=5
                @current_player.turn=true
            else
               puts "check it is" 
            end
            if @players.collect{|py|py if py.folded}.compact.count==@players.length-1
               @players.each{|py|@winner << py if !py.folded} 
               switch
               break
            end
            switch
            break if @players.all? {|py| py.turn}
        end
        @players.each do |py|
            py.turn=false if !py.folded
        end
    end

    def discard_round
        puts"anyone discarding?"
        loop do
            switch until !@current_player.folded
            @current_player.show_hand
            ans=@current_player.discard
           @deck.cards << @current_player.hand.delete_at(ans) if !ans.nil?
            @current_player.turn=true
            switch
            break if @players.all? {|py| py.turn}
        end

        @players.each do |py|
            py.turn=false if !py.folded
        end
        deal
    end

    def compare_hands
        if @players.collect {|py| py if !py.folded}.compact.count==2
            plays=@players.collect {|py| py if !py.folded}.compact

            h1=Hand.new(plays[0].hand)
            h2=Hand.new(plays[1].hand)

            win=h1.compare(h2)
            if win==h1
                @winner<<plays[0]
            elsif win=h2
                @winner<<plays[1]
            else
                @winner=plays
            end
        end
    end

            
    def round_play 
        loop do 
        bet_round
        compare_hands
        break if !@winner.empty?
        discard_round
        bet_round
        compare_hands
        break if !@winner.empty?
        end

        if @winner.length==1
            @winner[0].show_hand
            puts "#{@winner[0].name} wins pot" 
        elsif @winner.length>1
            puts "split pot"
            @winner.each do |py| 
                py.pot+=@g_pot/@winner.length
                puts "#{py.name} : #{py.show_hand}"
            end
        end

        @g_pot=0
        @players.each do |py|
            py.turn=false
            py.folded=false
            py.hand.each do |ca|
                @deck.cards<<ca
            end
        end
        @winner=[]
    end

    def play 
        puts "let's play"
        until @players.length ==1
        ante
        puts
        deal
        puts
        round_play
        @players.each {|py| @players-[py] if py.pot==0}
        switch
        end
        puts "#{@players[0]} wins the game"
    end
end

debugger
g=Game.new(["a","b","c",'d'])
g.play