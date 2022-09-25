require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board=board
    @next_mover_mark=next_mover_mark
    @prev_move_pos=prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return false if @board.winner == evaluator || @board.tied?
      return true
    end

    if @next_mover_mark == evaluator
      return children.all? {|child| child.losing_node?(evaluator)}
    else
      return children.any? {|child| child.losing_node?(evaluator)}
    end
    false
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
      return false
    end

    if @next_mover_mark == evaluator
      return children.any?{|child| child.winning_node?(evaluator)}
    else
      return children.all?{|child| child.winning_node?(evaluator)}
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_nodes=[]

    @board.rows.length.times do |row|
      @board.rows.length.times do |col|

        if @board.empty?([row,col])
          pos=[row,col]
          board_copy=@board.dup

          board_copy[pos]=@next_mover_mark
          next_move=TicTacToeNode.new(board_copy,switch,pos)
          next_nodes<<next_move
        end
      end
    end
    next_nodes
  end

  def switch
    @next_mover_mark == :x ? :o : :x
  end

  
end
