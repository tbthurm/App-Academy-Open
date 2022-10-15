class Employee
    attr_reader :name, :title, :salary
    attr_accessor :boss
    def initialize(name,title,salary,boss=nil)
        @name,@title,@salary,@boss=name,title,salary,boss
    end

    def bonus(multiplier)
        return self.salary*multiplier
    end
end

class Manager<Employee
    attr_reader :employees
    def initialize(name,title,salary,boss=nil)
        super(name,title,salary,boss)
        @employees=[]
    end

    def assign(*employee)
        employee.each do |em|
        @employees<<em
        em.boss=self.name
        end
    end

    def sub_salaries
        sum=0
        @employees.each {|employee| sum+=employee.salary}
        sum
    end

    def bonus(multiplier)
        sum=0
        @employees.each do |employee| 
            if employee.class==Manager
                sum+=employee.salary
                sum+=employee.sub_salaries
            else
                sum+=employee.salary
            end
        end
        sum*multiplier
    end
end
    
ned=Manager.new("ned","founder",1000000)
darren=Manager.new("darren","ta manager",78000)
shawna=Employee.new("shawna","ta",12000)
david=Employee.new("david","ta",10000)

ned.assign(darren)
darren.assign(shawna,david)


puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)