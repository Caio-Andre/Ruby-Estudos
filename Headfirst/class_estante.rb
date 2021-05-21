class Estante
    def initialize
        @livros = []
    end
  
    def filtrar 
      
    end
  
    def mostrar_livros_guardados
        puts "\n"
        @livros.each_key {|categoria|
          for livro in @livros[categoria]
            puts livro
          end
        }
    end
  
    def mostrar_livros_da_categoria categoria
      if @livros.has_key?categoria
        for livro in @livros[categoria]
          puts livro
        end
      else
        puts "Esta categoria não possui livros nesta biblioteca"
      end
    end
  end