module Stepable

    def moves
        path=[]
        move_diffs.each do |diff|
            new_pos=[@pos[0]+diff[0],@pos[1]+diff[1]]
            path<<new_pos.dup unless !@board.valid_pos?(new_pos) || @board.own_piece?(@pos,new_pos)
        end
        path
    end

 
    private
    def move_diffs
    end

end