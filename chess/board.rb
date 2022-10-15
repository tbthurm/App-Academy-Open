require_relative 'piece.rb'


class Board 
attr_accessor :rows
    def initialize
        @rows=Array.new(8){Array.new(8,NullPiece.instance)}
        place_pieces
    end

    def move_piece(color,start_pos,end_pos)
        pc= self[start_pos]

        
        raise "Not on board" if !valid_pos?(start_pos) || !valid_pos?(end_pos)
        raise "start position is empty" if pc==NullPiece.instance
        raise "Wrong side" if self[start_pos].color!=color
        raise "Own piece" if own_piece?(start_pos,end_pos)
        raise "will be in check" if !pc.valid_moves.include?(end_pos)
        
        if pc.valid_moves.include?(end_pos)
            self[end_pos]=pc
            self[end_pos].pos=end_pos
            self[start_pos]=NullPiece.instance
        else
            puts "invalid move"
        end
    end

    def own_piece?(start_pos,end_pos)
        return true if self[start_pos].color==self[end_pos].color
        false
    end

    def opp_piece?(start_pos,end_pos)
        return true if self[start_pos].color!=self[end_pos].color && self[end_pos]!=NullPiece.instance
        false
    end

    def [](pos)
        x,y=pos
        @rows[x][y]
    end

    def []=(pos,value)
        x,y=pos
        @rows[x][y]=value
    end

    def valid_pos?(pos)
        x,y=pos
       return x.between?(0,7)&&y.between?(0,7)
    end

    def place_pieces
        #pawn_placement
        (0..7).each{|y| @rows[1][y]=Pawn.new(:black,self,[1,y])}
        (0..7).each{|y| @rows[6][y]=Pawn.new(:white,self,[6,y])}

        #rook_placement
        @rows[0][0]=Rook.new(:black,self,[0,0])
        @rows[0][7]=Rook.new(:black,self,[0,7])
        @rows[7][0]=Rook.new(:white,self,[7,0])
        @rows[7][7]=Rook.new(:white,self,[7,7])

        #knight_placement
        @rows[0][1]=Knight.new(:black,self,[0,1])
        @rows[0][6]=Knight.new(:black,self,[0,6])
        @rows[7][1]=Knight.new(:white,self,[7,1])
        @rows[7][6]=Knight.new(:white,self,[7,6])

        #bishop_placement
        @rows[0][2]=Bishop.new(:black,self,[0,2])
        @rows[0][5]=Bishop.new(:black,self,[0,5])
        @rows[7][2]=Bishop.new(:white,self,[7,2])
        @rows[7][5]=Bishop.new(:white,self,[7,5])

        #king_placement
        @rows[0][4]=King.new(:black,self,[0,4])
        @rows[7][4]=King.new(:white,self,[7,4])

        #queen_placement
        @rows[0][3]=Queen.new(:black,self,[0,3])
        @rows[7][3]=Queen.new(:white,self,[7,3])
    end

    def in_check?(color)
        @rows.each do |row|
            row.each do |pc|
                if pc!=NullPiece.instance && pc.color!=color && pc.moves.include?(find_king(color))
                    return true
                end
            end
        end
        return false
    end

    def find_king(color)
        @rows.each do |row|
            row.each do |pc|
                if pc.color==color && pc.is_a?(King)
                    return pc.pos
                end
            end
        end
    end

    def checkmate?(color)
        @rows.each do |row|
            row.each do |pc|
                if pc.color!=color && pc.color!=:none
                    moves=pc.valid_moves.reject{|move| move!=find_king(color)}
                    moves.each do |move|
                        return true if valid_pos?(move) && in_check?(color) && self[find_king(color)].valid_moves.empty?
                    end
                end
            end
        end
        false
    end

    def move_piece!(st,en)
        x,y=st
        i,j = en
        @rows[i][j]=@rows[x][y]
        @rows[i][j].pos=[i,j]
        @rows[x][y]=NullPiece.instance
    end

    def rows_copy
        b=Board.new
        @rows.each do |row|
            row.each do |pc|
                x,y=pc.pos
                if pc.pos!=nil
                b.rows[x][y]=pc.class.new(pc.color,b,pc.pos)
                else
                    pc=NullPiece.instance
                end
            end
        end
        b
    end
end