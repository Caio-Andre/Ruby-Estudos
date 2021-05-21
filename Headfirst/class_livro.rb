class Livro

    attr_reader :genero, :titulo, :autor, :paginas, :preco
  
    def initialize(genero, titulo, autor, paginas, preco)
      @genero, @titulo, @autor, @paginas, @preco = genero, titulo, autor, paginas, preco
    end
  
    def ==(other)
      self.titulo == other.titulo && self.autor == other.autor && self.genero == other.genero
    end
  
  
    def to_s
      "Gênero:#{@genero}|Titulo:#{@titulo}|Autor:#{@autor}|Número de páginas:#{@paginas}|Preço:#{@preco}"
    end
  
end