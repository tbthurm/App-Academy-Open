class Queue
    attr_reader  :queue
    def initialize
        @queue=[]
    end

    def enqueue(el)
        @queue+=[el]
    end

    def dequeue
        @queue.delete(@queue.first)
    end

    def peek
        @queue.last
    end
end