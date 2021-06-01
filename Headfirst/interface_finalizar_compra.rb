require_relative 'classes'

# HAS CHANGED
def finalizar_compras(carrinho)
    
    puts "\n\n"
    print "[1] POSSUI CADASTRO  |  [2] FAZER CADASTRO: "
    decisao_cliente_cadastro = validar_entrada(2)
    if decisao_cliente_cadastro == 1
        while true do
            puts "LOGIN"
            print "SEU E-MAIL: "
            e_mail_cliente = gets.chomp.strip
            print "DIGITE SUA SENHA: "
            senha_cliente = gets.chomp.strip
            cliente = carregar_dados_cliente(e_mail_cliente,senha_cliente)
            if cliente == []
                puts "SEU E-MAIL OU SENHA ESTÃO INCORRETOS!!!"
                next
            end 
            break
        end 
        
    else
        cliente = fazer_cadastro
    end
    
    #HERE
    puts "\n\n"
    total = calcular_valor_final(carrinho.calcular_subtotal(cliente))

    escolher_forma_de_pagamento(total)

    puts "\n\n\n\nVATAPÁ STORE"
    print "\nVOCÊ DESEJA  [1 - CONFIRMAR COMPRA] [2 - SAIR DA LOJA] : "
    decisao_cliente = validar_entrada(2)
    if decisao_cliente == 1   
        puts "OBRIGRADO POR COMPRAR NA NOSSA LOJA!"
        puts "COMPRA FINALIZADA"
        app = false
    else 
        app = false
    end 

    ## ADICIONAR FORMAS DESCONTOS
end 