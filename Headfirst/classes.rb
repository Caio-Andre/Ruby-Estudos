class Livro

    attr_reader :id, :genero, :titulo, :autor, :paginas, :preco
  
    def initialize(id, genero, titulo, autor, paginas, preco)
      @id, @genero, @titulo, @autor, @paginas, @preco = id, genero, titulo, autor, paginas, preco
    end
  
    def ==(other)
      self.titulo == other.titulo && self.autor == other.autor && self.genero == other.genero
    end
  
  
    def to_s
      "\n[\033[1;37mID:#{@id}] \033[1;32mGênero:#{@genero}|\033[1;32mTitulo:#{@titulo}|\033[1;32mAutor:#{@autor}|\033[1;33mNúmero de páginas:#{@paginas}|\033[1;31mPreço:#{@preco}\033[m"
    end
  
end


class Estante
  attr_accessor :livros
  def initialize (livros)
      @livros = livros
  end

  # Essa função escolhe os livros da loja por meio do filtro passado
  def filtrar(filtro)
    if filtro == titulo
      for livro in livros
        if livro.titulo == filtro
          puts livro
          return livro
        end 
      end
      puts "LIVRO NÃO ENCONTRADO!" 
      return
    # As filtragens por meio de outros métodos serão feitas por aqui
    elsif  
    end 
  end 
end