class User
    def add(name)
        @name = name
        hello
        puts "User Adicionado!"
        
    end

    def hello
        puts "Seja bem vindo, #{@name}"
    end 
end 

user = User.new
user.add("Mário")