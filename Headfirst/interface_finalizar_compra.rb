require_relative 'classes'

def finalizar_compras(carrinho)
    
    puts "\n\n"
    total = calcular_valor_final(carrinho.calcular_subtotal)
    puts "\n\n"
    sleep(0.5)
    Gem.win_platform? ? (system "cls") : (system "clear")
    print "\033[34;1m[1] POSSUI CADASTRO  |  [2] FAZER CADASTRO: \033[m" ## COR
    decisao_cliente_cadastro = validar_entrada(2)
    if decisao_cliente_cadastro == 1
        
        while true do
            sleep(0.5)
            Gem.win_platform? ? (system "cls") : (system "clear")
            puts "\033[34;1m-=-" *4
            puts "\033[32;1mVATAPÁ STORE\033[m"
            puts "\033[34;1m-=-\033[m" *4
            puts "\n\n\033[32;1m|LOGIN|\033[m"
            print "\n\033[;1m[E-MAIL]: \033[m"
            e_mail_cliente = gets.chomp.strip
            print "\033[;1m[SENHA]: \033[m"
            senha_cliente = gets.chomp.strip
            cliente = carregar_dados_cliente(e_mail_cliente,senha_cliente)
            if cliente == []
                puts "\033[31;1mSEU E-MAIL OU SENHA ESTÃO INCORRETOS!!! \033[m"
                sleep(0.5)
                next
            end 
            break
        end 
        
    else
        sleep(0.5)
        cliente = fazer_cadastro
    end 

    escolher_forma_de_pagamento(total)
    Gem.win_platform? ? (system "cls") : (system "clear")
    puts "\033[34;1m-=-" *4
    puts "\033[32;1mVATAPÁ STORE\033[m"
    puts "\033[34;1m-=-\033[m" *4
    print "\nVOCÊ DESEJA  [1 - CONFIRMAR COMPRA] [2 - SAIR DA LOJA] : "
    decisao_cliente = validar_entrada(2)
    if decisao_cliente == 1   
        puts "OBRIGRADO POR COMPRAR NA NOSSA LOJA!"
        puts "COMPRA FINALIZADA"
        app = false
    else 
        app = false
    end 

    ## ADICIONAR FORMAS DESCONTOS ADICIONAR LOGIN E SENHA À INTERFACE DO FUNCIONÁRIO
end 