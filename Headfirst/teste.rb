require_relative "funcoes"
def escolher_forma_de_pagamento(total=50)
    puts "PAGAMENTO"
    print"\nSELECIONE UMA FORMA DE PAGAMENTO [1 - CARTÃO DE DÉBITO] [2 - CARTÃO DE CRÉDITO] [3 - BOLETO]: "
    decisao_cliente = 3
  
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
      puts "BOLETO GERADO"
      print """[#{gerar_boleto}]
  BENEFICIÁRIO: VATAPÁSTORE.LTDA
  
  DATA DOCUMENTO: #{dia_atual}/#{mes_atual}/#{ano_atual}  | Nº DOCUMENTO: #{gerar_num_documento}
  
  VALOR DOCUMENTO: R$#{total}
  
  >> O BOLETO VENCE EM 5 DIAS 
      """
    end 
  
      
end 

escolher_forma_de_pagamento

  
  
  