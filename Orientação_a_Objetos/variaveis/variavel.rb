class User 
    @@user_count = 0
    def add (name)
        puts "User #{name} adicionado"
        @@user_count +=1
        puts @@user_count
    end 
end 

usuario_1 = User.new
usuario_1.add("Lukitas")

usuario_2 = User.new
usuario_2.add("Amanda")