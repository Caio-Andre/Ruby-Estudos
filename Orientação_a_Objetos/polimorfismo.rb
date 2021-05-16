class Instrumento
    def escrever
        puts "Escrevendo"
    end 
end 

class Teclado < Instrumento
end 

class Lapis < Instrumento
    def escrever 
        puts "Escrevendo à lápis"
    end 
end 

class Caneta < Instrumento
    def escrever
        puts "Escrevendo à caneta"
    end 
end 

caneta_1 = Caneta.new
puts caneta_1.escrever()

teclado_1 = Teclado.new
puts "\n#{teclado_1.escrever()}"

