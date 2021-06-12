require_relative "classes"


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
    puts "\n\033[32;1m                                                                                      [TOTAL = R$%0.2f]\033[m" % [total]
  else 
    total = 40 + subtotal
    puts "\n\033[32;1m                                                                                      [TOTAL = R$%0.2f]\033[m" % [total]
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
    print "\033[;1mEM QUANTAS VEZES GOSTARIA DE PAGAR(ATÉ 6 VEZES): \033[m"
    parcelamento = validar_entrada(6)
    puts format("\n\033[;1mVALOR DA PARCELA: R$%.2f\033[m", total/parcelamento.to_f)
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