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
    livros_desejados = []
    contador = 1

    for livro in livros
      if livro.titulo == filtro
        livros_desejados << livro
      end
      
      if livro.autor == filtro
        livros_desejados << livro 
      end 

      if livro.genero == filtro
        livros_desejados << livro 
      end 
    end 

    if livros_desejados == []
      puts "\n\033[1;31mLIVRO NÃO ENCONTRADO NO ESTOQUE!\033[m" 
      return
    else
      puts livros_desejados
      return livros_desejados
    end     
  end 

  def filtrar_por_paginas
    livros_desejados = []
    puts "\nFILTRO: [1]0-100 PAGINAS  [2]100-200 PAGINAS  [3]200-300 PAGINAS  [4]+300 PAGINAS"
    print "ESCOLHA UM FILTRO: "

    filtro_por_paginas_cliente = validar_entrada(4)
    
    for livro in livros 
      if filtro_por_paginas_cliente == 1
        if livro.paginas <= 100
          livros_desejados << livro
        end 

      elsif filtro_por_paginas_cliente == 2    
        if livro.paginas > 100 && livro.paginas <=200
          livros_desejados << livro
        end 
      
      elsif filtro_por_paginas_cliente == 3 
        if livro.paginas > 200 && livro.paginas <= 300
          livros_desejados << livro
        end 
        
      else 
        if livro.paginas > 300
          livros_desejados << livro  
        end   
      end 
    end
    puts livros_desejados
    return livros_desejados
    
  end 

end