require_relative 'poly_tree'

class KnightPathFinder

    def initialize(start_pos)
       @root_node=PolyTreeNode.new(start_pos)
       @considered_pos=[@root_node]
    
    def build_move_tree
        que=[@root_node]

        while !que.empty?
        current=que.shift
        new_move_positions(current.value).each do |new_pos|
            node=PolyTreeNode.new(new_pos)
            current.add_child(node)
            que.push(node)
        end
        end
        @root_node
    end

    end

    def self.valid_moves(pos)
        additions= [ [1, 2],[ 1, -2],[-1,  2],
            [ -1,  -2],[2, 1],[-2,  1],[ 2, -1],
            [ -2,  -1]]

            additions.collect do |move|
                new_move = [pos,move].transpose.map(&:sum)
                new_move if new_move.all?{|el| el.between?(0,7)}
            end.compact
    end

    def new_move_positions(pos)
        moves=KnightPathFinder.valid_moves(pos)
        moves.reject! {|el| @considered_pos.include?(el)}
        moves.each {|move| @considered_pos.push(move)}
        moves
    end

end