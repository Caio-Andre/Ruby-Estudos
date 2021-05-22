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

  def filtrar (filtro)
    if   
      for livro in livros
        if livro.titulo == filtro
          puts livro
          return livro
        end 
      end
      puts "LIVRO NÃO ENCONTRADO!" 
      return  
    end 
  end 
end