require_relative "classes"


############################################################ CLASSE PAGAMENTO
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

VALOR DOCUMENTO: R$%0.2f

>> O BOLETO VENCE EM 5 DIAS\033[m""" % [total]
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
##################################################################FIM CLASSE PAGAMENTO


##################################################################CLASSE VALIDADOR DE PAGAMENTO
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
########################################################FIM DE CLASSE