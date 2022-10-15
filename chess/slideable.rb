module Slideable
    
    def horizontal_dirs
        HORIZ_DIRS
    end
    
    def diagonal_dirs
        DIAG_DIRS
    end

    def moves
        path=[]

        move_dirs.each do |dir|
            new_pos=[@pos[0]+dir[0],@pos[1]+dir[1]]

           until !@board.valid_pos?(new_pos) || @board.own_piece?(@pos,new_pos)
            path<<new_pos.dup
            break if @board.opp_piece?(@pos,new_pos)
            new_pos[0]+=dir[0]
            new_pos[1]+=dir[1]
           end
        end
        path
    end


    private
    HORIZ_DIRS = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    DIAG_DIRS = [[1, 1], [-1, 1], [-1, -1], [1, -1]] 

    def move_dirs
        horizontal_dirs
        diagonal_dirs
    end
end 