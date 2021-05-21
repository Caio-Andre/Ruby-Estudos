class Livro

    attr_reader :id, :genero, :titulo, :autor, :paginas, :preco
  
    def initialize(id, genero, titulo, autor, paginas, preco)
      @genero, @titulo, @autor, @paginas, @preco = genero, titulo, autor, paginas, preco
    end
  
    def ==(other)
      self.titulo == other.titulo && self.autor == other.autor && self.genero == other.genero
    end
  
  
    def to_s
      "[\033[1;37ID:#{@id}] \033[1;33mGênero:#{@genero}|\033[1;33Titulo:#{@titulo}|\033[1;33Autor:#{@autor}|\033[1;32Número de páginas:#{@paginas}|\033[1;31Preço:#{@preco}"
    end
  
end