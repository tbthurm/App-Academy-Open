class Array

    def my_uniq        
        new=[]
        self.each {|el| new<<el if !new.include?(el)}
        new
    end

    def two_sum
        new=[]
        self.each.with_index do |num1,i1|
            self.each.with_index do |num2,i2|
                return [] if num1.class==String || num2.class==String
                if num1!=nil && num2!=nil && num1+num2==0 && i2>i1
                    new<<[i1,i2] 
                    self[i2]=nil
                end
            end
        end
        new
    end
      
    def my_transpose
        new_arr=[]

        until self[0].empty?
        new_arr<<self.map {|el| el.delete_at(0)}
        end
        new_arr
    end

    def stock_picker
        profit={}
        (0...self.length).each do |i1|
            (i1+1...self.length).each do |i2|
                next if self[i2]<self[i1]
                profit[[i1,i2]]=self[i2]-self[i1]
            end
        end
        profit.key(profit.values.max)
    end
end