class Map

   def initialize
    @map=[]
   end

   def set(key,value)
       if !@map.empty? && !(@map.collect{|pairs| pairs if pairs[0]==key}.compact).empty?
        @map.each.with_index do |pairs,i|
           pairs[1]=value if pairs[0]==key
        end

    else

    pair={}
    pair[key]=value
    @map.push ([pair.keys,pair.values].flatten)
    end
   end

   def get(key)
    @map.each do |pairs|
        return pairs if pairs[0]==key
    end
    nil
   end

   def delete(key)
    @map.each do |pairs|
        if pairs[0]==key
            @map.delete(pairs) 
            return @map
        end
    end
    nil
   end

   def show
    @map
   end
end