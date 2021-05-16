class Person
    def initialize(name, age)
        @name = name
        @age = age
    end

    def check
        puts "Instancia de classe iniciada com os valores:"
        puts "Name = #{@name}"
        puts "Age = #{@age}"
    end
end

p1 = Person.new("João", 15)
p1.check