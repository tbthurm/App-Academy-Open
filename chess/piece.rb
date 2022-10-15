require 'singleton'
require 'colorize'
require_relative 'stepable.rb'
require_relative 'slideable.rb'

class Piece
attr_accessor :pos, :color
    def initialize(color,board,pos)
        @color=color
        @board=board
        @pos=pos
    end

    def valid_moves
        moves.collect {|pos| pos if !move_into_check?(pos)}.compact
    end
 
    def symbol
    end

    def to_s
        if @color==:white
            return " #{symbol.colorize(:blue).bold} "
        else
            return " #{symbol.colorize(:red).bold} "
        end
    end

    private
    def move_into_check?(end_pos)
        ck=@board.rows_copy
        ck.move_piece!(@pos,end_pos)
        return ck.in_check?(@color)
    end 

end

class NullPiece < Piece
    attr_reader :symbol, :color
    include Singleton

    def initialize
        @symbol=" "
        @color=:none
    end
end

class Pawn<Piece

    def symbol
        return "♙"
    end

    def moves
        forward_step+side_attacks
    end

    private
    def at_start_row?
        return true if @pos[0] == 6 && @color == :white
        return true if @pos[0] == 1 && @color == :black
        return false 
    end

    def forward_dir
        return -1 if @color == :white
        return 1 if @color == :black
    end

    def forward_step
        path=[]
        new_pos=[@pos[0]+forward_dir,@pos[1]]
        path<<new_pos if @board[new_pos]==NullPiece.instance

        step_two=[@pos[0]+forward_dir*2,@pos[1]]
        path<<step_two if at_start_row? && @board[step_two]==NullPiece.instance

        path
    end

    def side_attacks
        path=[]
        left_dia=[@pos[0] + forward_dir,@pos[1] + forward_dir]
        right_dia=[@pos[0] + forward_dir,@pos[1] - forward_dir]

        if @board.valid_pos?(left_dia) && @board[left_dia].color !=@color && @board[left_dia]!=NullPiece.instance
            path<<left_dia
        end

        if @board.valid_pos?(right_dia) && @board[right_dia].color !=@color && @board[right_dia]!=NullPiece.instance
            path<<right_dia
        end
        path
    end

end

class Knight<Piece
    include Stepable

    def symbol
        return "♘"
    end

    protected 
    def move_diffs
        return [
            [1, 2],[1, -2],[-1, 2],
                [-1, -2],[2, 1],[2, -1],
                [-2, 1],[-2, -1]
            ]
    end
end

class King<Piece
    include Stepable

    def symbol
        '♔'
    end

    protected
    def move_diffs
        return [[0, 1],[0, -1],[1, 0],
                [-1, 0],[1, 1],[1, -1],
                [-1, 1],[-1, -1]]
    end
end

class Queen<Piece
    include Slideable

    def symbol
        return "♕"
    end

    def move_dirs
        horizontal_dirs+diagonal_dirs
    end
end

class Rook<Piece
    include Slideable

    def symbol
        return "♖"
    end

    def move_dirs
        horizontal_dirs
    end
end

class Bishop<Piece
    include Slideable

    def symbol
        return "♗"
    end

    def move_dirs
        diagonal_dirs
    end
end