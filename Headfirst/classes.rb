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
    livros_filtrados = []
    contador = 1

    for livro in livros
      if livro.titulo == filtro
        livros_filtrados << livro
      end
      
      if livro.autor == filtro
        livros_filtrados << livro 
      end 

      if livro.genero == filtro
        livros_filtrados << livro 
      end 
    end 

    if livros_filtrados == []
      puts "\n\033[1;31mLIVRO NÃO ENCONTRADO NO ESTOQUE!\033[m" 
      return
    else
      return livros_filtrados
    end     
  end 

  def filtrar_por_paginas
    livros_filtrados = []
    puts "\nFILTRO: [1]0-100 PAGINAS  [2]100-200 PAGINAS  [3]200-300 PAGINAS  [4]+300 PAGINAS"
    print "ESCOLHA UM FILTRO: "

    filtro_por_paginas_cliente = validar_entrada(4)
    
    for livro in livros 
      if filtro_por_paginas_cliente == 1
        if livro.paginas <= 100
          livros_filtrados << livro
        end 

      elsif filtro_por_paginas_cliente == 2    
        if livro.paginas > 100 && livro.paginas <=200
          livros_filtrados << livro
        end 
      
      elsif filtro_por_paginas_cliente == 3 
        if livro.paginas > 200 && livro.paginas <= 300
          livros_filtrados << livro
        end 
        
      else 
        if livro.paginas > 300
          livros_filtrados << livro  
        end   
      end 
    end
    return livros_filtrados
  end 
  
  def selecionar_livros_desejados (livros_filtrados)
    livros_desejados = []
    puts "LIVROS ENCONTRADOS:\n", livros_filtrados
    print "\nVOCÊ DESEJA ADICIONAR ALGUM DESSES LIVROS NO CARRINHO [1 - Sim] [2 - Não]: "
    decisao = validar_entrada(2)

    if decisao == 2
      return livros_desejados
    else
      while decisao == 1 do
        puts "\nINDIQUE O LIVRO DESEJADO PELO ID:"
        id = gets.chomp.strip.to_i 
        for livro in livros_filtrados
          if livro.id == id
            livros_desejados << livro
            puts "LIVRO ADICIONADO AO CARRINHO"
          end 
        end 

        puts "\nVOCÊ QUE ADICIONAR OUTRO LIVRO [1 - Sim] [2 - Não]: "
        decisao = validar_entrada(2)
        if decisao == 1
          puts "LIVROS ENCONTRADOS:\n", livros_filtrados
        end 
      end 
    end
    return livros_desejados
  end  
end

class Carrinho 
  def initialize 
    @lista_de_compras = []
  end 
  def adicionar_carrinho (livros_desejados)
    @lista_de_compras.push(*livros_desejados)
    puts "SEU CARRINHO ATUAL:\n", @lista_de_compras
  end
end 