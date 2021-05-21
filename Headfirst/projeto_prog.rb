class Livro

    attr_reader :genero, :titulo, :autor, :paginas, :preco
  
    def initialize(genero, titulo, autor, paginas, preco)
      @genero, @titulo, @autor, @paginas, @preco = genero, titulo, autor, paginas, preco
    end
  
    def ==(other)
      self.titulo == other.titulo && self.autor == other.autor && self.genero == other.genero
    end
  
  
    def to_s
      "Titulo: #{@titulo};/nAutor: #{@autor};/nGênero: #{@genero};/nNúmero de páginas: #{@paginas};/nPreço: #{@preco}"
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
livro_1 = Livro.new("Acao","Inferno","eu",5,10)
estante_1 = Estante.new

File.open("books.txt", "a") do |file|
  file.write("\nGenero: #{livro_1.genero} Titulo:#{livro_1.titulo}")
end 

list_of_books = File.new("books.txt").readlines
puts 