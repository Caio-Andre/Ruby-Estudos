require 'base64'
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

  # RECEBE O LOGIN OU FAZ O CADSTRO DO CLIENTE E RETORNA UM OBJETO CLIENTE
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
            return cliente
        end 
    else
        return self.adicionar_clientes_banco_de_dados
    end
  end 

  # LER O ARQUIVO TXT, COMPARA AS INFORMACOES DO CLIENTE E RETORNA UM OBJETO CLIENTE
  def self.carregar_dados_cliente(e_mail_cliente,senha_cliente)
    fregues = nil
    File.open("banco_de_dados_clientes.txt") do |file|
      file.each do |line|
        #HERE
        if e_mail_cliente == line.chomp.split("|")[8] && senha_cliente == decrypt(line.chomp.split("|")[9])
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

  
  # RECEBE OS DADOS DE CADASTRO DO CLIENTE, ESCREVE OS DADOS NO TXT E RETORNA UM OBJETO CLIENTE
  def self.adicionar_clientes_banco_de_dados
    while true
      print "INFORME O SEU NOME COMPLETO: "
      nome = gets.chomp.strip.upcase
      print "INFORME O DIA DO SEU NASCIMENTO (XX) : "
      dia_nascimento = gets.chomp.strip.upcase
      print "INFORME O MES DO SEU NASCIMENTO (XX) : "
      mes_nascimento = gets.chomp.strip.upcase
      print "INFORME O ANO DO SEU NASCIMENTO (XXXX) : "
      ano_nascimento = gets.chomp.strip.upcase
      print "INFORME O ESTADO (XX) : "
      estado = gets.chomp.strip.upcase
      print "INFORME A SUA CIDADE: "
      cidade = gets.chomp.strip.upcase
      print "INFORME O NÚMERO DA SUA RESIDÊNCIA: "
      numero = gets.chomp.strip
      print "INFORME O SEU CEP (SEM HÍFEN): "
      cep = gets.chomp.strip.upcase
      print "\nINFORME O SEU E-MAIL PARA LOGIN: "
      e_mail = gets.chomp.strip.downcase
      print "\nINFORME O SUA SENHA PARA LOGIN: "
      senha = gets.chomp.strip.downcase

      dados_validos = self.validar_cadastro_cliente(nome,dia_nascimento,mes_nascimento,ano_nascimento,estado,cidade,numero,cep,e_mail,senha)

      if not dados_validos
        puts "\n\n"
        next
      end

      puts("""NOME: [#{nome}]
DATA DE NASCIMENTO: #{dia_nascimento}/#{mes_nascimento}/#{ano_nascimento}
ENDEREÇO: ESTADO[#{estado}] CIDADE[#{cidade}] NUMERO[#{numero}] CEP[#{cep}]
E-MAIL: [#{e_mail}]""")
      puts "SEUS DADOS ESTÃO CORRETOS [Sim - 1] [Não - 2]: "
      decisao_cliente = validar_entrada(2)
      next if decisao_cliente == 2
       
      File.open("banco_de_dados_clientes.txt", "a") do |arquivo|
        arquivo.puts("#{nome}|#{dia_nascimento}|#{mes_nascimento}|#{ano_nascimento}|#{estado}|#{cidade}|#{numero}|#{cep}|#{e_mail}|#{encrypt(senha).chomp}|#{0.0}")
      end

      puts "CADASTRO REALIZADO COM SUCESSO!"
      return self.carregar_dados_cliente(e_mail, senha)
    end
  end 

  # RECEBE OS DADOS CADASTRAIS DO CLIENTE E CHECA SE HÁ ALGUM INVALIDO
  def self.validar_cadastro_cliente(nome,dia_nascimento,mes_nascimento,ano_nascimento,estado,cidade,numero,cep,e_mail,senha)
    numbers = ['0','1','2','3','4','5','6','7','8','9']
    states = ['AC','AL','AP','AM','BA','CE','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO','DF']
    letters = ('A'..'Z').to_a
    valido = true

    numbers.each do |number|
      if nome.include? number
        puts "\n\033[31;1mNOME INVALIDO\033[m"
        valido = false
        break
      end 
    end 
    
    if not states.include? estado
      puts "\n\033[31;1mESTADO INVALIDO\033[m"
      valido = false
    end 
    
    letters.each do |letter|
      if dia_nascimento.include? letter
        puts "\n\033[31;1mDIA INVALIDO\033[m"
        valido = false
        break
      end 
    end 

    letters.each do |letter|
      if mes_nascimento.include? letter
        puts "\n\033[31;1mMES INVALIDO\033[m"
        valido = false
        break
      end 
    end 
    
    letters.each do |letter|
      if ano_nascimento.include? letter
        puts "\n\033[31;1mANO INVALIDO\033[m"
        valido = false
        break
      end 
    end 

    if mes_nascimento.size != 2 || dia_nascimento.size != 2 || ano_nascimento.size != 4
      puts  "\n\033[31;1mDIA E MES DEVEM TER [2] DIGITOS E ANO [4] DIGITOS\033[m"
      valido = false
    end 

    if cep.size != 8
      puts  "\n\033[31;1mCEP DEVE POSSUIR 8 DIGITOS \033[m"
      valido = false
    end 

    letters.each do |letter|
      if cep.include? letter
        puts "\n\033[31;1mCEP INVALIDO\033[m"
        valido = false
        break
      end 
    end 

    if not e_mail.include? "@"
      puts "\n\033[31;1mE_MAIL INVALIDO\033[m"
      valido = false
    end 

    return valido
  end 

  # LER O ARQUIVO TXT, COMPARA O LOGIN DO CLIENTE, ATUALIZA O ATRIBUTO DESCONTO DO OBJETO E ATUALIZA O ARQUIVO TXT COM O NOVO OBJETO
  def atualizar_desconto_do_cliente
    clientes = []
    File.open("banco_de_dados_clientes.txt") do |file|
      file.each do |line|
        dados_do_cliente = line.chomp.split("|")
        descontao = dados_do_cliente.last
        dados_do_cliente.delete(descontao)
        fregues = Cliente.new(*dados_do_cliente)
        fregues.desconto = descontao.to_f
        clientes << fregues
      end 
    end

    for cliente_com_desconto_desatualizado in clientes
      if cliente_com_desconto_desatualizado.senha == self.senha && cliente_com_desconto_desatualizado.e_mail == self.e_mail
        clientes.delete(cliente_com_desconto_desatualizado)
        clientes << self
      end
    end

    File.open("banco_de_dados_clientes.txt", "w") do |arquivo|
    end

    for cliente in clientes
      File.open("banco_de_dados_clientes.txt", "a") do |arquivo|
        arquivo.puts("#{cliente.nome}|#{cliente.dia_nascimento}|#{cliente.mes_nascimento}|#{cliente.ano_nascimento}|#{cliente.estado}|#{cliente.cidade}|#{cliente.numero}|#{cliente.cep}|#{cliente.e_mail}|#{cliente.senha}|#{cliente.desconto}")
      end
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

# RECEBE O LOGIN DO FUNCIONARIO E FAZ A VALIDACAO PARA PERMITIR O ACESSO AO ESTOQUE 
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

# ESCREVE NO TXT TODA VEZ QUE UM FUNCIONARIO ENTRA NO ESTOQUE, SALVANDO A DATA E A HORA 
  def registrar_entrada_do_funcionario
    File.open("registro_de_login.txt", "a") do |arquivo|
      arquivo.puts("#{@e_mail}|#{Time.now}")
    end
  end


  # PERMITE O FUNCIONARIO ADICIONAR LIVROS AO ESTOQUE 
  def adicionar_livros_banco_de_dados(estante)
    Gem.win_platform? ? (system "cls") : (system "clear")
      while true
        print "\n\033[;1mINFORME O TÍTULO DO LIVRO: \033[m"
        titulo = gets.chomp.strip.upcase
        livro_no_estoque = false 
        for livro in estante.livros 
            if livro.titulo == titulo
                puts "\n\033[;1mLIVRO JÁ EXISTENTE NO ESTOQUE\033[m" 
                livro_no_estoque = true
                break
            end 
        end 
        if livro_no_estoque == false
          id = self.gerar_id_disponível(estante)
          print "\033[;1mINFORME O GENÊRO DO LIVRO: \033[m"
          genero = gets.chomp.upcase
          print "\033[;1mINFORME O AUTOR DO LIVRO: \033[m"
          autor = gets.chomp.upcase
          print "\033[;1mINFORME O NÚMERO DE PÁGINAS DO LIVRO: \033[m"
          paginas = gets.chomp.to_i
          print "\033[;1mINFORME O PREÇO DO LIVRO: \033[m"
          preco = gets.chomp.to_f
    
          File.open("banco_de_dados_livros.txt", "a") do |arquivo|
            arquivo.puts("#{id}|#{genero}|#{titulo}|#{autor}|#{paginas}|#{preco}")
          end
          puts "\n\033[32;1mLIVRO ADICIONADO COM SUCESSO!\033[m"
        end
        estante.carregar_livros
        puts "\n\033[;1mVOCÊ DESEJA ADICIONAR UM LIVRO DIFERENTE [Sim - 1] [Não - 2]: \033[m"
        decisao_funcionario = validar_entrada(2)
        if decisao_funcionario == 2
          break
        end
      end
  end 

  # PERMITE O FUNCIONARIO REMOVER LIVROS AO ESTOQUE
  def remover_livros_banco_de_dados(estante)
    Gem.win_platform? ? (system "cls") : (system "clear")
      while true do
        print "\033[;1mINDIQUE UMA INFORMAÇÃO DO LIVRO A SER REMOVIDO(Título/Gênero/Autor): "
        filtro = gets.chomp.strip.upcase
        livros_a_serem_removidos = estante.filtrar(filtro)
        if livros_a_serem_removidos != nil
          puts livros_a_serem_removidos
        else
          print "\n\033[;1mVOCÊ DESEJA PROCURAR POR OUTRO LIVRO [Sim - 1][Não - 2]: \033[m"
          decisao_funcionario = validar_entrada(2)
          if decisao_funcionario == 1
            next
          else
            break
          end 
        end  
        print "\n\033[;1mINFORME O ID DO LIVRO A SER REMOVIDO: \033[m"
        estante.carregar_livros
        id = validar_id(estante.livros)
        for livro in estante.livros
          if livro.id == id 
            estante.livros.delete(livro)
            puts 
          end 
        end 
          File.open("banco_de_dados_livros.txt", "w") do |arquivo|
          end
        for livro in estante.livros
          File.open("banco_de_dados_livros.txt", "a") do |arquivo|
            arquivo.puts("#{livro.id}|#{livro.genero}|#{livro.titulo}|#{livro.autor}|#{livro.paginas}|#{livro.preco}")
          end
        end 
        puts "\n\033[31;1mLIVRO REMOVIDO!\033[m"

        print "\n\033[;1mVOCÊ QUER REMOVER OUTRO LIVRO: [Sim - 1] [Não - 2]: \033[m"
        decisao_funcionario = validar_entrada(2)
        if decisao_funcionario == 1
          Gem.win_platform? ? (system "cls") : (system "clear")
          next
        else
          break
        end 
      end 
  end 

  # RETORNA O MENOR VALOR DE ID DISPONIVEL PARA CADASTRO DE LIVRO
  def gerar_id_disponível(estante)
    ids_invalidos = []
    for livro in estante.livros
      ids_invalidos << livro.id
    end 
    id_valido = 0
    while true
      if not ids_invalidos.include? id_valido
        return id_valido
      else 
        id_valido += 1
      end 
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
      sleep(0.5) 
      Gem.win_platform? ? (system "cls") : (system "clear")
      return
    else
      return livros_filtrados
    end     
  end 

  # FILTRA A LISTA DE LIVROS PELA QUANTIDADE DE PÁGINAS ESPECIFICAMENTE
  def filtrar_por_paginas
    livros_filtrados = []
    puts "\n\033[34;1mFILTRO: [1]0-99 PAGINAS  [2]100-200 PAGINAS  [3]201-300 PAGINAS  [4]+300 PAGINAS\033[m"
    print "\033[;1mESCOLHA UM FILTRO: \033[m"

    filtro_por_paginas_cliente = validar_entrada(4)
    # FILTRA OS LIVROS COM MENOS 100 PAGINAS
    for livro in @livros 
      if filtro_por_paginas_cliente == 1
        if livro.paginas <= 100
          livros_filtrados << livro
        end 
    # FILTRA OS LIVROS ENTRE 100 E 200 PAGINAS
      elsif filtro_por_paginas_cliente == 2    
        if livro.paginas > 100 && livro.paginas <=200
          livros_filtrados << livro
        end 
    # FILTRA OS LIVROS ENTRE 201 E 300 PAGINAS
      elsif filtro_por_paginas_cliente == 3 
        if livro.paginas > 200 && livro.paginas <= 300
          livros_filtrados << livro
        end 
    # FILTRA OS LIVROS COM MAIS DE 300 PAGINAS
      else 
        if livro.paginas > 300
          livros_filtrados << livro  
        end   
      end 
    end

    if livros_filtrados == []
      puts "\n\033[1;31mLIVRO NÃO ENCONTRADO NO ESTOQUE!\033[m"
      sleep(0.5) 
      Gem.win_platform? ? (system "cls") : (system "clear")
      return
    else
      return livros_filtrados
    end 
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
    @subtotal = 0
  end 
  
  def adicionar_carrinho (livros_desejados)
    @lista_de_compras.push(*livros_desejados)
    puts "\n\033[;1mSEU CARRINHO ATUAL:\033[m", @lista_de_compras
  end

  def mostrar_lista_compras
    puts "\n\033[34;1mLIVROS NO CARRINHO: \033[m", @lista_de_compras
  end 

  # CALCULA O FRETE E RETORNA A SOMA DO FRETE COM O SUBTOTAL EM FORMA DE TOTAL 
  def calcular_valor_final(cliente)
    Gem.win_platform? ? (system "cls") : (system "clear")
    puts "\033[34;1m-=-" *4
    puts "\033[32;1mVATAPÁ STORE\033[m"
    puts "\033[34;1m-=-\033[m" *4
    puts "\n\n\033[34;1m|ESCOLHA SEU FRETE|\033[m"
    print """\n\033[;1m[1] PAC >> 10 - 15 DIAS PARA ENTREGA | R$25,00
[2] SEDEX >> 2 - 6 DIAS PARA ENTREGA | R$40,00 
FRETE: \033[m"""
    opção_frete_cliente = validar_entrada(2)
    if opção_frete_cliente == 1
      total = 25 + self.calcular_desconto(cliente)
      puts "\n\033[32;1m                                                                                      [TOTAL = R$%0.2f]\033[m" % [total]
    else 
      total = 40 + self.calcular_desconto(cliente)
      puts "\n\033[32;1m                                                                                      [TOTAL = R$%0.2f]\033[m" % [total]
    end 
    return total 
  end

# CALCULA O DESCONTO E O MANIPULA DE ACORDO COM A ESCOLHA DO CLIENTE 
  def calcular_desconto(cliente)
    if cliente.desconto == 0.0
      bonus = @subtotal / 10
      cliente.desconto += bonus
      puts "\n\033[31;1m                                                                                      [SUBTOTAL = R$#{@subtotal}]\033[m"
      return @subtotal
    end 
    
    print "\033[;1mVOCÊ POSSUI UM DESCONTO DE RS %0.2f " % [cliente.desconto]
    print "DESEJA APLICÁ-LO NO VALOR TOTAL DA SUA COMPRA? [Sim - 1] [Não - 2]: \033[m"
    decisao_cliente = validar_entrada(2)
    if decisao_cliente == 1
      @subtotal -= cliente.desconto
      cliente.desconto = 0.0
      
      
      puts "\n\033[31;1m                                                                                      [Subtotal = R$%0.2f]\033[m" % [@subtotal]
      return @subtotal
    else
      bonus = @subtotal / 10
      cliente.desconto += bonus
      puts "\n\033[31;1m                                                                                      [Subtotal = R$%0.2f]\033[m" % [@subtotal]
      return @subtotal
    end
  end 

  # SOMA O VALOR DOS LIVROS QUE ESTAO ATUALMENTE NA LISTA DE COMPRAS 
  def calcular_subtotal
    @subtotal = 0
    for livro in @lista_de_compras
      @subtotal += livro.preco 
    end 
    puts "\n\033[31;1m                                                                                      [Subtotal = R$%0.2f]\033[m" % [@subtotal]
    return @subtotal
  end

  # PERMITE O CLIENTE MODIFICAR A QUANTIDADE DE LIVROS DENTRO DO CARRINHO, SEJA PARA ADICIONAR EXEMPLARES SEJA PARA EXCLUIR EXEMPLARES
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
            Gem.win_platform? ? (system "cls") : (system "clear")
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

class Finalizador_de_Compra
  # DEFINE O MEIO QUE O CLIENTE IRA UTILIZAR PARA PAGAR 
  def escolher_forma_de_pagamento(total)
    puts "\033[34;1mPAGAMENTO\033[m"
    print"\n\033[;1mSELECIONE UMA FORMA DE PAGAMENTO [1 - CARTÃO DE DÉBITO] [2 - CARTÃO DE CRÉDITO] [3 - BOLETO]: \033[m"
    decisao_cliente = validar_entrada(3)
  
    if decisao_cliente == 1
      self.validar_dados_do_cartao
    elsif decisao_cliente == 2
      self.validar_dados_do_cartao 
      print "\033[;1mEM QUANTAS VEZES GOSTARIA DE PAGAR(ATÉ 6 VEZES): \033[m"
      parcelamento = validar_entrada(6)
      puts format("\n\033[;1mVALOR DA PARCELA: R$%.2f\033[m", total/parcelamento.to_f)
    else #47
      ano_atual = Time.new.year 
      mes_atual = Time.new.month 
      dia_atual = Time.new.day
      Gem.win_platform? ? (system "cls") : (system "clear")
      puts "\033[34;1mBOLETO GERADO \033[m"
      print """\n\033[;1mCÓDIGO DO DOCUMENTO: [#{self.gerar_boleto}]
BENEFICIÁRIO: VATAPÁSTORE.LTDA
  
DATA DOCUMENTO: #{dia_atual}/#{mes_atual}/#{ano_atual}  | Nº DOCUMENTO: #{self.gerar_num_documento}
  
VALOR DOCUMENTO: R$%0.2f
  
>> O BOLETO VENCE EM 5 DIAS\033[m""" % [total]
    end 
  
  end 
  
  # AVALIA AS ENTRADAS DOS USUARIO E DETERMINA SE O CARTAO E VALIDO OU NAO 
  def validar_dados_do_cartao 
    ano_atual = Time.new.year % 2000
    mes_atual = Time.new.month 
    dia_atual = Time.new.day
  
    valido = false
      while not valido 
        print "\033[;1mNOME TITULAR DO CARTÃO: "
        nome_titular_cartao = gets.chomp.strip.upcase
        print "\nINFORME O NÚMERO DO CARTÃO: "
        numero_cartao_cliente = gets.chomp.strip
        print "\nMES DE VENCIMENTO DO CARTÃO (2 Dígitos): "
        mes_cartao_vencimento = gets.chomp.strip
        print "\nANO DE VENCIMENTO DO CARTÃO (2 Dígitos): "
        ano_cartao_vencimento = gets.chomp.strip
        print "\nCÓDIGO DE SEGURANÇA (3 Dígitos): \033[m"
        codigo_seguranca_cartao = gets.chomp.strip
  
        if ano_atual < ano_cartao_vencimento.to_i
          valido = numero_cartao_cliente.size == 16 && mes_cartao_vencimento.size == 2 && ano_cartao_vencimento.size == 2 && codigo_seguranca_cartao.size == 3  
        else
          valido = numero_cartao_cliente.size == 16 && mes_cartao_vencimento.size == 2 && ano_cartao_vencimento.size == 2 && codigo_seguranca_cartao.size == 3 && mes_cartao_vencimento.to_i >= mes_atual && ano_cartao_vencimento.to_i >= ano_atual 
        end 
  
        if not valido 
          puts "\n\n\033[31;1mDADOS DO CARTÃO INVÁLIDO!\033[m"
        else
          puts "\n\n\033[32;1mCARTÃO APROVADO\033[m" 
        end
      end  
  
  end 
  
  # GERA UM NUMERO ALEATORIO PARA O BOLETO DO CLIENTE
  def gerar_boleto
    num_boleto = ""
    contador = 0
    while contador < 44
      num_boleto += rand(0..9).to_s
      contador += 1
    end 
    return num_boleto
  end 
  
  # GERA UM NUMERO DE DOCUMENTO ALEATORIO USADO NO BOLETO
  def gerar_num_documento
    num_documento = ""
    contador = 0
    while contador < 7
      num_documento += rand(0..9).to_s
      contador += 1
    end 
    return num_documento
  end
end 



def validar_entrada (numero_de_opcoes_validas) 
  opções = (1..numero_de_opcoes_validas).to_a
  escolha_usuario = gets.chomp.strip.to_i
  while true do   
    if opções.include? escolha_usuario
        return escolha_usuario

    else
      puts "\nOPÇÃO INVÁLIDA"
      print "ESCOLHA ENTRE AS OPÇÕES VÁLIDAS #{opções}: "
      escolha_usuario = gets.chomp.strip.to_i
    end 
  end 
end 


# RECEBE O NÚMERO DE OPÇÕES VÁLIDAS E SÓ RETORNA A FUNÇÃO QUANDO A ENTRADA DO USUÁRIO É VÁLIDA E SE O LIVRO EXISTE NA LISTA DE LIVROS
def validar_id (lista_de_livros)
  escolha_usuario_id = gets.chomp.strip.to_i
  while true do
    for livro in lista_de_livros
      if livro.id == escolha_usuario_id
        return escolha_usuario_id
      end 
    end 
    puts "\n\033[31;1mOPÇÃO INVÁLIDA -- LIVRO NÃO FAZ PARTE DA LISTA\033[m"
    print "\n\033[;1mINSIRA OUTRO ID: \033[m"
    escolha_usuario_id = gets.chomp.strip.to_i
  end 
end 
  
# CRIPTOGRAFA A SENHA DO CLIENTE
def encrypt(input_string)
  Base64.encode64(input_string)
end

# DESCRIPTOGRAFA A SENHA DO CLIENTE
def decrypt(encrypted_string)
  Base64.decode64(encrypted_string)
end


