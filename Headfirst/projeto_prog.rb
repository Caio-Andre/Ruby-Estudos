class Livro

    attr_accessor :titulo, :autor, :categoria, :paginas, :preco
  
    def initialize(genero, titulo, autor, paginas, preco)
      @genero, @titulo, @autor, @paginas, @preco = genero, titulo, autor, paginas, preco
    end
  
    def ==(other)
      self.titulo == other.titulo && self.autor == other.autor && self.genero == other.genero && self.paginas == other.paginas && self.preco == other.preco
    end
  
  
    def to_s
      "Gênero: #{@genero}; Titulo: #{@titulo}; Autor: #{@autor}; Paginas: #{@paginas}; Preco: #{@preco}"
    end
  
  end
  
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
