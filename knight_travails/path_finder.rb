require_relative 'poly_tree'

class KnightPathFinder

    def initialize(start_pos)
       @considered_pos=[start_pos]
       @root_node = build_move_tree(start_pos)
    end
    
    def build_move_tree(pos)
        start=PolyTreeNode.new(pos)
        que=[start]

        while !que.empty?
        current=que.shift
        new_move_positions(current.value).each do |new_pos|
            node=PolyTreeNode.new(new_pos)
            current.add_child(node)
            que.push(node)
        end
        end
        start
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

    def find_path(end_pos)
        path=@root_node.bfs(end_pos)

        trace_path_back(path).reverse.map(&:value)
    end

    def trace_path_back(node)
      return [node] if node.parent.nil?
      [node]+trace_path_back(node.parent)
    end

end

if $PROGRAM_NAME == __FILE__
    kpf = KnightPathFinder.new([0, 0])
    p kpf.find_path([7, 6])
    p kpf.find_path([6, 2])
end