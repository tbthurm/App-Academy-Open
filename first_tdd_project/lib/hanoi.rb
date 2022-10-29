class Hanoi
    attr_accessor :piles

    def initialize
        @piles=Array.new(3){Array.new}
        @piles[0]=[1,2,3,4]
    end

    def play
        until won?
            render
            res=prompt
            move_disc(res[0]-1,res[1]-1)
        end
        puts "victory"
    end

    def move_disc(start_pos,end_pos)
        raise ArgumentError if !start_pos.between?(0,2) || !end_pos.between?(0,2)

        if @piles[end_pos][0].nil? || @piles[start_pos][0]<@piles[end_pos][0]
            @piles[end_pos].unshift(@piles[start_pos].shift)
        else 
            raise ArgumentError
        end
    end

    def prompt
        puts "give which pile to take 1,2, or 3"
        st_po=gets.chomp
        puts "give which pile to place 1,2, or 3 :don't choose same"
        en_po=gets.chomp

        if st_po==en_po
            puts "same pile"
            prompt
        end

        [st_po.to_i,en_po.to_i]
    end

    def won?
        return true if @piles[-1]==[1,2,3,4]
        return false
    end

    def render 
        @piles.each{|pile| p pile}
    end
end

Hanoi.new.play