class Robot
attr_accessor :position, :items ,:health
    def initialize
        @position=[0,0]
        @items=[]
        @health=100
        @equipped=nil
    end

    def move_left
        @position[0]+=-1
    end

    def move_right
        @position[0]+=1
    end

    def move_up
        @position[1]+=1
    end

    def move_down
        @position[1]+=-1
    end

    def pick_up(item)
        if (items_weight+item.weight) <=250 
            @items<<item
        else
            raise ArgumentError
        end
    end

    def items_weight
        sum=0
        @items.each {|item| sum+=item.weight}
        sum
    end

    def wound(points)
        if @health-points>=0
        @health-=points
        else 
            @health=0
        end
    end

    def heal(points)
        if @health+points>100
            @health=100
        else
        @health+=points 
        end
    end

    def attack(target)
        if equipped_weapon==nil
        target.wound(5)
        else 
            equipped_weapon.hit(target)
        end
    end

    def equipped_weapon
        @equipped 
    end

    def equipped_weapon=(weapon)
        @equipped = weapon
    end


end

class Item
attr_reader :name , :weight
    def initialize(name,weight)
        @name,@weight=name,weight
    end
end

class Bolts<Item
    def initialize
        super("bolts",25)
    end

    def feed(target)
        target.heal(25)
    end   
end

class Weapon<Item
attr_reader :name, :weight, :damage
    def initialize(name,weight,damage)
        super(name,weight)
        @damage=damage
    end

    def hit(target)
        target.wound(45)
    end
end

class Laser<Weapon
    def initialize
        super("laser",125,25)
    end
end

class PlasmaCannon<Weapon
    def initialize
        super("plasma_cannon",200,55)
    end
end