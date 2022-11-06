class LRUCache
  attr_reader :size, :cache
    def initialize(size)
        @size=size
        @cache=[]
    end

    def count
      @cache.length
    end

    def add(el)
      @cache.shift if @cache.count==@size
      if !@cache.include?(el)
        @cache.push(el)
      else 
        @cache.delete(el)
        @cache.push(el)
      end
    end

    def show
      @cache
    end
  end

  # johnny_cache = LRUCache.new(4)
# 
  # johnny_cache.add("I walk the line")
  # johnny_cache.add(5)
# 
  # p johnny_cache.count 
# 
  # johnny_cache.add([1,2,3])
  # johnny_cache.add(5)
  # johnny_cache.add(-5)
  # johnny_cache.add({a: 1, b: 2, c: 3})
  # johnny_cache.add([1,2,3,4])
  # johnny_cache.add("I walk the line")
  # johnny_cache.add(:ring_of_fire)
  # johnny_cache.add("I walk the line")
  # johnny_cache.add({a: 1, b: 2, c: 3})
# 
# 
  # p johnny_cache.show 