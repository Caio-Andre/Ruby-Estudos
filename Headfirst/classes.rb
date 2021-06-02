class Livro

    attr_reader :id, :genero, :titulo, :autor, :paginas, :preco
  
    def initialize(id, genero, titulo, autor, paginas, preco)
      @id, @genero, @titulo, @autor, @paginas, @preco = id, genero, titulo, autor, paginas, preco
    end
  
    def ==(other)
      self.titulo == other.titulo && self.autor == other.autor && self.genero == other.genero
    end
  
  
    def to_s
      "\n\033[1;37m[ID:#{@id}] \033[1;32mGênero:#{@genero}|\033[1;32mTitulo:#{@titulo}|\033[1;32mAutor:#{@autor}|\033[1;33mNúmero de páginas:#{@paginas}|\033[1;31mPreço:R$#{@preco}\033[m"
    end
  
end

class Cliente

  attr_reader :nome, :dia_nascimento, :mes_nascimento, :ano_nascimento, :estado, :cidade, :numero, :cep, :e_mail, :senha 
  attr_accessor :desconto

  def initialize(nome, dia_nascimento, mes_nascimento, ano_nascimento, estado, cidade, numero, cep, e_mail, senha)
    @nome, @dia_nascimento, @mes_nascimento, @ano_nascimento, @estado, @cidade, @numero, @cep, @e_mail, @senha = nome, dia_nascimento, mes_nascimento, ano_nascimento, estado, cidade, numero, cep, e_mail, senha
  end

  def to_s
    """NOME: [#{@nome}]
DATA DE NASCIMENTO: #{@dia_nascimento}/#{@mes_nascimento}/#{@ano_nascimento}
ENDEREÇO: ESTADO[#{@estado}] CIDADE[#{@cidade}] NUMERO[#{@numero}] CEP[#{@cep}]
E-MAIL: [#{@e_mail}]"""
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
    puts "\n\033[34;1mFILTRO: [1]0-100 PAGINAS  [2]100-200 PAGINAS  [3]200-300 PAGINAS  [4]+300 PAGINAS\033[m"
    print "\033[;1mESCOLHA UM FILTRO: \033[m"

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
    puts "\033[34;1mLIVROS ENCONTRADOS:\033[m", livros_filtrados
    print "\n\033[;1mVOCÊ DESEJA ADICIONAR ALGUM DESSES LIVROS NO CARRINHO [Sim - 1] [Não - 2]: \033[m"
    decisao = validar_entrada(2)

    if decisao == 2
      return livros_desejados
    else
      while decisao == 1 do
        print "\n\033[;1mINDIQUE O LIVRO DESEJADO PELO ID: \033[m"
        id = validar_id(livros_filtrados)
        for livro in livros_filtrados
          if livro.id == id
            livros_desejados << livro
            puts "\033[32;1m!LIVRO ADICIONADO AO CARRINHO! \033[m"
          end 
        end 

        print "\n\033[;1mVOCÊ QUE ADICIONAR OUTRO LIVRO [Sim - 1] [Não - 2]: \033[m"
        decisao = validar_entrada(2)
        if decisao == 1
          Gem.win_platform? ? (system "cls") : (system "clear")
          puts "\033[34;1mLIVROS ENCONTRADOS:\033[m", livros_filtrados
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
    puts "\nSEU CARRINHO ATUAL:", @lista_de_compras
  end

  def mostrar_lista_compras
    puts "\n\033[34;1mLIVROS NO CARRINHO: \033[m", @lista_de_compras
  end 
  
  #HAS CHANGED
  def calcular_desconto(cliente)
    subtotal = 0
    for livro in @lista_de_compras
      subtotal += livro.preco 
    end
    if cliente.desconto == 0.0
      bonus = subtotal / 10
      cliente.desconto += bonus
      atualizar_desconto_do_cliente(cliente)
      # Adicionar cor mais tarde
      puts "\n\033[31;1m                                                                                      [SUBTOTAL = R$#{subtotal}]\033[m"
      return subtotal
    end 
    print "\033[;1mVOCÊ POSSUI UM DESCONTO DE RS#{cliente.desconto} "
    print "DESEJA APLICÁ-LO NO VALOR TOTAL DA SUA COMPRA? [Sim - 1] [Não - 2]: \033[m"
    decisao_cliente = validar_entrada(2)
    if decisao_cliente == 1
      subtotal -= cliente.desconto
      cliente.desconto = 0.0
      atualizar_desconto_do_cliente(cliente)
      # Adicionar cor mais tarde
      puts "\n\033[31;1m                                                                                      [SUBTOTAL = R$#{subtotal}]\033[m"
      return subtotal
    else
      bonus = subtotal / 10
      cliente.desconto += bonus
      atualizar_desconto_do_cliente(cliente)
      # Adicionar cor mais tarde
      puts "\n\033[31;1m                                                                                      [SUBTOTAL = R$#{subtotal}]\033[m"
      return subtotal
    end
  end 

  def calcular_subtotal
    subtotal = 0
    for livro in @lista_de_compras
      subtotal += livro.preco 
    end 
    puts "\n\033[31;1m                                                                                      [Subtotal = R$#{subtotal}]\033[m"
    return subtotal
  end

  def alterar_carrinho
    Gem.win_platform? ? (system "cls") : (system "clear")
    puts "\n\033[34;1mLIVROS NO CARRINHO:\n\n\033[m", @lista_de_compras
    calcular_subtotal
    while true do
      print "\n\033[;1mVOCÊ DESEJA MUDAR A QUANTIDADE DE UM LIVRO OU REMOVÊ-LO [Quantidade - 1] [Remover - 2]: \033[m"
      decisao_cliente = validar_entrada(2)
      if decisao_cliente == 1
        while true do 
          print "\n\033[;1mINDIQUE O LIVRO  PELO ID: \033[m"
          id = validar_id(@lista_de_compras)
          print "\033[;1mADICIONAR QUANTOS EXEMPLARES: \033[m"
          quantidade_de_exemplares = gets.chomp.strip.to_i ## substituir por uma validacao
          contador = 0
          for livro in @lista_de_compras
            if livro.id == id
              while contador < quantidade_de_exemplares
                indice = @lista_de_compras.index(livro)
                @lista_de_compras.insert(indice + 1, livro)
                contador += 1
              end
            end
          end
          sleep(0.5)
          Gem.win_platform? ? (system "cls") : (system "clear")
          puts "\n\033[34;1mLIVROS NO CARRINHO:\n\n\033[m", @lista_de_compras
          calcular_subtotal
          print "\033[;1mVOCÊ DESEJA ALTERAR A QUANTIDADE DE OUTRO LIVRO [Sim - 1] [Não - 2]: \033[;1m"
          decisao_cliente = validar_entrada(2)
          if decisao_cliente == 2
            break
          end
          puts "\n\033[34;1mLIVROS NO CARRINHO:\n\n\033[m", @lista_de_compras
          calcular_subtotal
        end 
      
      else
        while true do
            Gem.win_platform? ? (system "cls") : (system "clear")
            puts "\n\033[34;1mLIVROS NO CARRINHO:\n\n\033[m", @lista_de_compras
            calcular_subtotal
            print"\n\033[;1mINDIQUE O LIVRO PARA SER REMOVIDO PELO ID: \033[m"
            id = validar_id(@lista_de_compras)
            print "\033[;1mREMOVER QUANTOS EXEMPLARES: \033[m"
            quantidade_de_exemplares = gets.chomp.strip.to_i
            contador = 0
            for livro in @lista_de_compras
              if livro.id == id
                if contador < quantidade_de_exemplares
                  indice = @lista_de_compras.index(livro)
                  @lista_de_compras.delete_at(indice)
                  puts "\033[31;1m!LIVRO REMOVIDO DO CARRINHO!\033[m"
                  contador += 1
                else 
                  break 
                end 
              end 
            end
            sleep(0.5)
            puts "\n\033[34;1mLIVROS NO CARRINHO:\n\n\033[34;1m", @lista_de_compras
            calcular_subtotal
            print "\033[;1mVOCÊ DESEJA REMOVER OUTRO LIVRO [Sim - 1] [Não - 2]: \033[m"
            decisao = validar_entrada(2)
            if decisao == 2
              break
            end 
            Gem.win_platform? ? (system "cls") : (system "clear")
            puts "\n\033[34;1mLIVROS NO CARRINHO:\n\n\033[m", @lista_de_compras
            calcular_subtotal
            
        end 
      end 

      print "\n\033[;1mVOCÊ DESEJA FAZER MAIS ALGUMA ALTERÇÃO NO CARRINHO [Sim - 1] [Não - 2]: \033[m"
      decisao = validar_entrada(2)
      if decisao == 2
          break
      end

    end 
  end 
end 

