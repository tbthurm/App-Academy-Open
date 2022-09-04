class PolyTreeNode
    attr_reader :parent , :children , :value

    def initialize(value)
        @parent=nil
        @children=[]
        @value=value
    end

    def parent=(node)
        if @parent
            old = @parent
            old.children.delete(self)
        end

        @parent = node
        !node ? return : node.children.push(self)
    end

    def add_child(child_node)
        child_node.parent=(self)
    end

    def remove_child(child_node)
        raise 'Bad parent=!' if self.children.none?(child_node)
        child_node.parent=(nil)
    end

    def dfs(target_value)
        return self if self.value === target_value

        self.children.each do |nodes|
            search=nodes.dfs(target_value)
            return search if !search.nil?
        end
        nil
    end

    def bfs(target_value)
        arr=[self]
        return self if self.value === target_value
        arr=self.children 

        while !arr.empty?
            return arr.first if arr.first.value === target_value
            arr.push(arr.first.children).flatten!.shift
        end
        nil
    end

end