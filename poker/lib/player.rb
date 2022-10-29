class Player
attr_reader :name
attr_accessor :pot, :hand, :folded, :turn

    def initialize(name)
        @name=name
        @hand=[]
        @pot=500
        @folded=false
        @turn=false
    end

    def discard
        puts "#{@name}, choose which cards to discard"
        dis=gets.chomp.to_i - 1
        if (dis).between?(0,@hand.length-1)
            return dis
        else
            return nil
        end 
    end

    def choose 
        puts "choose fold,see(call),or raise :use f,s, or r"
        ch=gets.chomp.downcase
        if %w(f s r).include?(ch)
            return ch
        else
            puts "invalid choice"
            choose
        end
    end

    def show_hand
        @hand.each {|ca| p ca.to_s}
    end
end