class Blender 
    def close_lid
    puts "Sealed tight!"
    end 

    def blend (speed)
        puts "Spinnig on #{speed} setting."
    end 

end 
a = getshe
puts "hello"
blender = Blender.new
blender.close_lid
blender.blend("high")

