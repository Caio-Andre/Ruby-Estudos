require_relative "classes"

# LER OS LIVROS DO BANCO DE DADOS E CRIA OBJETOS DA CLASSE LIVROS. 
def carregar_livros
  livros = []
  File.open("banco_de_dados_livros.txt") do |file|
    file.each do |line| 
      id, genero, titulo, autor, paginas, precos = line.chomp.split("|")
      livros << Livro.new(id.to_i, genero, titulo, autor, paginas.to_i, precos.to_f)
    end 
  end
  return livros
end


# ADICIONA NOVOS LIVROS NO BANCO
def adicionar_livros_banco_de_dados(estante)
  while true
    print "INFORME O TÍTULO DO LIVRO: "
    titulo = gets.chomp.strip.upcase
    livro_no_estoque = false 
    for livro in estante.livros 
        if livro.titulo == titulo
            puts "\nLIVRO JÁ EXISTENTE NO ESTOQUE" 
            livro_no_estoque = true
            break
        end 
    end 
    if livro_no_estoque == false
      id = gerar_id_disponível(estante)
      print "INFORME O GENÊRO DO LIVRO: "
      genero = gets.chomp.upcase
      print "INFORME O AUTOR DO LIVRO: "
      autor = gets.chomp.upcase
      print "INFORME O NÚMERO DE PÁGINAS DO LIVRO: "
      paginas = gets.chomp.to_i
      print "INFORME O PREÇO DO LIVRO: "
      preco = gets.chomp.to_f

      File.open("banco_de_dados_livros.txt", "a") do |arquivo|
        arquivo.puts("#{id}|#{genero}|#{titulo}|#{autor}|#{paginas}|#{preco}")
      end
      puts "LIVRO ADICIONADO COM SUCESSO!"
    end 
    puts "\nVOCÊ DESEJA ADICIONAR UM LIVRO DIFERENTE [Sim - 1] [Não - 2]: "
    decisao_funcionario = validar_entrada(2)
    if decisao_funcionario == 2
      break
    end
  end
end 

def remover_livros_banco_de_dados(estante)
  while true do
    print "INDIQUE UMA INFORMAÇÃO DO LIVRO A SER REMOVIDO(Título/Gênero/Autor): "
    filtro = gets.chomp.strip.upcase
    livros_a_serem_removidos = estante.filtrar(filtro)
    if livros_a_serem_removidos != nil
      puts livros_a_serem_removidos
    else
      print "\nVOCÊ DESEJA PROCURAR POR OUTRO LIVRO [Sim - 1][Não - 2]: "
      decisao_funcionario = validar_entrada(2)
      if decisao_funcionario == 1
        next
      else
        break
      end 
    end  
    print "INFORME O ID DO LIVRO A SER REMOVIDO: "
    id = gets.chomp.to_i
    for livro in estante.livros
      if livro.id == id 
        estante.livros.delete(livro)
        puts 
      end 
    end 
    puts estante.livros
      File.open("banco_de_dados_livros.txt", "w") do |arquivo|
      end
    for livro in estante.livros
      File.open("banco_de_dados_livros.txt", "a") do |arquivo|
        arquivo.puts("#{livro.id}|#{livro.genero}|#{livro.titulo}|#{livro.autor}|#{livro.paginas}|#{livro.preco}")
      end
    end 
    print "VOCÊ QUER REMOVER OUTRO LIVRO: [Sim - 1] [Não - 2]: "
    decisao_funcionario = validar_entrada(2)
    if decisao_funcionario == 1
      next
    else
      break
    end 
  end 
    
end 




#HAS CHANGED
def atualizar_desconto_do_cliente(cliente_com_desconto_atualizado)
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
    if cliente_com_desconto_desatualizado.senha == cliente_com_desconto_atualizado.senha && cliente_com_desconto_desatualizado.e_mail == cliente_com_desconto_atualizado.e_mail
      clientes.delete(cliente_com_desconto_desatualizado)
      clientes << cliente_com_desconto_atualizado
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

# HAS CHANGED
# ADICIONA NOVOS LIVROS NO BANCO
def adicionar_clientes_banco_de_dados
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

# HAS CHANGED
# LER OS LIVROS DO BANCO DE DADOS E CRIA OBJETOS DA CLASSE LIVROS. 
def carregar_dados_cliente(e_mail_cliente,senha_cliente)
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

# CALCULA O FRETE E RETORNA A SOMA DO FRETE COM O SUBTOTAL
def calcular_valor_final(subtotal)
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
    total = 25 + subtotal
    puts "\033[32;1m                                                                                      [TOTAL = R$#{total}]\033[m"
  else 
    total = 40 + subtotal
    puts "\033[32;1m                                                                                      [TOTAL = R$#{total}]\033[m"
  end 
  return total 
end


# DEFINE A FORMA DE PAGAMENTO DA COMPRA E VÁLIDA A FORMA
def escolher_forma_de_pagamento(total)
  puts "\033[34;1mPAGAMENTO\033[m"
  print"\n\033[;1mSELECIONE UMA FORMA DE PAGAMENTO [1 - CARTÃO DE DÉBITO] [2 - CARTÃO DE CRÉDITO] [3 - BOLETO]: \033[m"
  decisao_cliente = validar_entrada(3)

  if decisao_cliente == 1
    validar_dados_do_cartao
  elsif decisao_cliente == 2
    validar_dados_do_cartao 
    print "EM QUANTAS VEZES GOSTARIA DE PAGAR(ATÉ 6 VEZES): "
    parcelamento = validar_entrada(6)
    puts format("VALOR DA PARCELA: R$%.2f", total/parcelamento.to_f)
  else #47
    ano_atual = Time.new.year 
    mes_atual = Time.new.month 
    dia_atual = Time.new.day
    Gem.win_platform? ? (system "cls") : (system "clear")
    puts "\033[34;1mBOLETO GERADO \033[m"
    print """\n\033[;1mCÓDIGO DO DOCUMENTO: [#{gerar_boleto}]
BENEFICIÁRIO: VATAPÁSTORE.LTDA

DATA DOCUMENTO: #{dia_atual}/#{mes_atual}/#{ano_atual}  | Nº DOCUMENTO: #{gerar_num_documento}

VALOR DOCUMENTO: R$#{total}

>> O BOLETO VENCE EM 5 DIAS\033[m"""
  end 

end 

# AVALIA AS ENTRADAS DOS USUARIO E DETERMINA SE O CARTAO E VALIDO
def validar_dados_do_cartao 
  ano_atual = Time.new.year % 2000
  mes_atual = Time.new.month 
  dia_atual = Time.new.day

  valido = false
    while not valido 
      print "NOME TITULAR DO CARTÃO: "
      nome_titular_cartao = gets.chomp.strip.upcase
      print "INFORME O NÚMERO DO CARTÃO: "
      numero_cartao_cliente = gets.chomp.strip
      print "MES DE VENCIMENTO DO CARTÃO (2 Dígitos): "
      mes_cartao_vencimento = gets.chomp.strip
      print "ANO DE VENCIMENTO DO CARTÃO (2 Dígitos): "
      ano_cartao_vencimento = gets.chomp.strip
      print "CÓDIGO DE SEGURANÇA (3 Dígitos): "
      codigo_seguranca_cartao = gets.chomp.strip

      if ano_atual < ano_cartao_vencimento.to_i
        valido = numero_cartao_cliente.size == 16 && mes_cartao_vencimento.size == 2 && ano_cartao_vencimento.size == 2 && codigo_seguranca_cartao.size == 3  
      else
        valido = numero_cartao_cliente.size == 16 && mes_cartao_vencimento.size == 2 && ano_cartao_vencimento.size == 2 && codigo_seguranca_cartao.size == 3 && mes_cartao_vencimento.to_i >= mes_atual && ano_cartao_vencimento.to_i >= ano_atual 
      end 

      if not valido 
        puts "DADOS DO CARTÃO INVÁLIDO!"
      else
        puts "CARTÃO APROVADO" 
      end
    end  

end 

def gerar_boleto
  num_boleto = ""
  contador = 0
  while contador < 44
    num_boleto += rand(0..9).to_s
    contador += 1
  end 
  return num_boleto
end 

def gerar_num_documento
  num_documento = ""
  contador = 0
  while contador < 7
    num_documento += rand(0..9).to_s
    contador += 1
  end 
  return num_documento
end 




# RECEBE O NÚMERO DE OPÇÕES VÁLIDAS E SÓ RETURNA A FUNÇÃO QUANDO A ENTRADA DO USUÁRIO É VÁLIDA
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