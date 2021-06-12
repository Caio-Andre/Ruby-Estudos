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

  def self.acessar_loja_pelo_cadastro
  print "\n\033[;1m[1] POSSUI CADASTRO  |  [2] FAZER CADASTRO: "
    decisao_cliente_cadastro = validar_entrada(2)
    if decisao_cliente_cadastro == 1
        while true do
            puts "\n\033[34;1mLOGIN\033[m"
            print "\033[;1mSEU E-MAIL: \033[m"
            e_mail_cliente = gets.chomp.strip
            print "\033[;1mDIGITE SUA SENHA: \033[m"
            senha_cliente = gets.chomp.strip
            cliente = self.carregar_dados_cliente(e_mail_cliente,senha_cliente)
            if cliente == nil
                puts "\033[31;1mSEU E-MAIL OU SENHA ESTÃO INCORRETOS!!!\033[m"
                next
            end 
            break
        end 
    else
        cliente = self.adicionar_clientes_banco_de_dados
    end
  end 

  def self.carregar_dados_cliente(e_mail_cliente,senha_cliente)
    fregues = nil
    File.open("banco_de_dados_clientes.txt") do |file|
      file.each do |line|
        #HERE
        if e_mail_cliente == line.chomp.split("|")[8] && senha_cliente == line.chomp.split("|")[9]
          dados_do_cliente = line.chomp.split("|")
          descontao = dados_do_cliente.last
          dados_do_cliente.delete(descontao)
          fregues = Cliente.new(*dados_do_cliente)
          fregues.desconto = descontao.to_f
        end 
      end 
    end
    return fregues
  end

# HAS CHANGED
# ADICIONA NOVOS LIVROS NO BANCO
def self.adicionar_clientes_banco_de_dados
  while true
    print "INFORME O SEU NOME COMPLETO: "
    nome = gets.chomp.strip.upcase
    print "INFORME O DIA DO SEU NASCIMENTO: "
    dia_nascimento = gets.chomp.strip
    print "INFORME O MES DO SEU NASCIMENTO: "
    mes_nascimento = gets.chomp.strip
    print "INFORME O ANO DO SEU NASCIMENTO: "
    ano_nascimento = gets.chomp.strip
    print "INFORME O ESTADO: "
    estado = gets.chomp.strip.upcase
    print "INFORME A SUA CIDADE: "
    cidade = gets.chomp.strip.upcase
    print "INFORME O NÚMERO DA SUA RESIDÊNCIA: "
    numero = gets.chomp.strip
    print "INFORME O SEU CEP: "
    cep = gets.chomp.strip

    print "\nINFORME O SEU E-MAIL PARA LOGIN: "
    e_mail = gets.chomp.strip.downcase

    print "\nINFORME O SUA SENHA PARA LOGIN: "
    senha = gets.chomp.strip.downcase

    puts("""NOME: [#{nome}]
DATA DE NASCIMENTO: #{dia_nascimento}/#{mes_nascimento}/#{ano_nascimento}
ENDEREÇO: ESTADO[#{estado}] CIDADE[#{cidade}] NUMERO[#{numero}] CEP[#{cep}]
E-MAIL: [#{e_mail}]""")
    puts "SEUS DADOS ESTÃO CORRETOS [Sim - 1] [Não - 2]: "
    decisao_cliente = validar_entrada(2)
    next if decisao_cliente == 2
    # HERE   
    File.open("banco_de_dados_clientes.txt", "a") do |arquivo|
      arquivo.puts("#{nome}|#{dia_nascimento}|#{mes_nascimento}|#{ano_nascimento}|#{estado}|#{cidade}|#{numero}|#{cep}|#{e_mail}|#{senha}|#{0.0}")
    end

    puts "CADASTRO REALIZADO COM SUCESSO!"
    return [e_mail, senha] 
   
  end
end 



  def to_s
    """NOME: [#{@nome}]
DATA DE NASCIMENTO: #{@dia_nascimento}/#{@mes_nascimento}/#{@ano_nascimento}
ENDEREÇO: ESTADO[#{@estado}] CIDADE[#{@cidade}] NUMERO[#{@numero}] CEP[#{@cep}]
E-MAIL: [#{@e_mail}]"""
  end



end

class Funcionario
  attr_accessor :e_mail, :senha, :arquivo

  @@funcionarios = []

  def initialize(e_mail,senha)
    @e_mail, @senha = e_mail, senha 
  end 


  def self.logar
    File.open("banco_de_dados_funcionarios.txt") do |file|
      file.each do |line| 
        @@funcionarios << line
      end 
    end
  
    while true do
      Gem.win_platform? ? (system "cls") : (system "clear")
      puts "\033[34;1mLOGIN - FUNCIONÁRIO\033[m"
      print "\n\033[;1mSEU E-MAIL: \033[m"
      e_mail = gets.chomp.strip
      print "\033[;1mDIGITE SUA SENHA: \033[m"
      senha = gets.chomp.strip
      
      for dados in @@funcionarios
        e_mail_total, senha_total = dados.split("|")
        if e_mail_total == e_mail && senha == senha_total
          return Funcionario.new(e_mail, senha)
        else
          puts "\n\033[31;1mE-MAIL OU SENHA INCORRETO\033[m"
          sleep(0.5)
        end 
      end
    end 
  end  


  def registrar_entrada_do_funcionario
    File.open("registro_de_login.txt", "a") do |arquivo|
      arquivo.puts("#{@e_mail}|#{Time.now}")
    end
  end
end 

class Estante
  attr_accessor :livros
  def initialize 
    @livros = []
  end

  # LER OS LIVROS DO BANCO DE DADOS E CRIA OBJETOS DA CLASSE LIVROS. 
  def carregar_livros
    @livros = []
    File.open("banco_de_dados_livros.txt") do |file|
      file.each do |line| 
        id, genero, titulo, autor, paginas, precos = line.chomp.split("|")
        @livros << Livro.new(id.to_i, genero, titulo, autor, paginas.to_i, precos.to_f)
      end 
    end
  end


  # FILTRA A LISTA DE LIVROS A PARTIR DO FILTRO ESPECIFICADO PELO USUÁRIO 
  def filtrar(filtro)
    livros_filtrados = []
    contador = 1

      
    for livro in @livros
      # CHECA SE O TITULO DO LIVRO PASSADO PELO USUARIO EXISTE NA LISTA DE LIVROS DA LOJA
      if livro.titulo == filtro
        livros_filtrados << livro
      end
      
      # CHECA SE O AUTOR DO LIVRO PASSADO PELO USUARIO EXISTE NA LISTA DE LIVROS DA LOJA
      if livro.autor == filtro
        livros_filtrados << livro 
      end 

      # CHECA SE O GENERO DO LIVRO PASSADO PELO USUARIO EXISTE NA LISTA DE LIVROS DA LOJA
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

  # FILTRA A LISTA DE LIVROS PELA QUANTIDADE DE PÁGINAS ESPECIFICAMENTE
  def filtrar_por_paginas
    livros_filtrados = []
    puts "\n\033[34;1mFILTRO: [1]0-100 PAGINAS  [2]100-200 PAGINAS  [3]200-300 PAGINAS  [4]+300 PAGINAS\033[m"
    print "\033[;1mESCOLHA UM FILTRO: \033[m"

    filtro_por_paginas_cliente = validar_entrada(4)
    
    for livro in @livros 
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

  attr_accessor :lista_de_compras
  def initialize 
    @lista_de_compras = []
  end 
  
  def adicionar_carrinho (livros_desejados)
    @lista_de_compras.push(*livros_desejados)
    puts "\n\033[;1mSEU CARRINHO ATUAL:\033[m", @lista_de_compras
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
    
    print "\033[;1mVOCÊ POSSUI UM DESCONTO DE RS %0.2f " % [cliente.desconto]
    print "DESEJA APLICÁ-LO NO VALOR TOTAL DA SUA COMPRA? [Sim - 1] [Não - 2]: \033[m"
    decisao_cliente = validar_entrada(2)
    if decisao_cliente == 1
      subtotal -= cliente.desconto
      cliente.desconto = 0.0
      atualizar_desconto_do_cliente(cliente)
      # Adicionar cor mais tarde
      puts "\n\033[31;1m                                                                                      [Subtotal = R$%0.2f]\033[m" % [subtotal]
      return subtotal
    else
      bonus = subtotal / 10
      cliente.desconto += bonus
      atualizar_desconto_do_cliente(cliente)
      # Adicionar cor mais tarde
      puts "\n\033[31;1m                                                                                      [Subtotal = R$%0.2f]\033[m" % [subtotal]
      return subtotal
    end
  end 

  def calcular_subtotal
    subtotal = 0
    for livro in @lista_de_compras
      subtotal += livro.preco 
    end 
    puts "\n\033[31;1m                                                                                      [Subtotal = R$%0.2f]\033[m" % [subtotal]
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
          print "\n\033[;1mINDIQUE O LIVRO PELO ID: \033[m"
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

