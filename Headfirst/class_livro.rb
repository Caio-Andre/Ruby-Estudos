class Livro

    attr_reader :id, :genero, :titulo, :autor, :paginas, :preco
  
    def initialize(id, genero, titulo, autor, paginas, preco)
      @genero, @titulo, @autor, @paginas, @preco = genero, titulo, autor, paginas, preco
    end
  
    def ==(other)
      self.titulo == other.titulo && self.autor == other.autor && self.genero == other.genero
    end
  
  
    def to_s
      "\n[\033[1;37mID:#{@id}] \033[1;33mGênero:#{@genero}|\033[1;33mTitulo:#{@titulo}|\033[1;33mAutor:#{@autor}|\033[1;32mNúmero de páginas:#{@paginas}|\033[1;31mPreço:#{@preco}\033[m"
    end
  
end