require_relative 'classes'

def finalizar_compras(carrinho)
    
    carrinho.mostrar_lista_compras
    carrinho.calcular_subtotal
    print "\nVOCÊ DESEJA ALTERAR O CARRINHO [1 - Sim] [2 - Não]: "
    decisao_cliente = validar_entrada(2)
    
    if decisao_cliente == 1
        carrinho.alterar_carrinho
    end 
    puts "\n\n"
    calcular_frete(carrinho.calcular_subtotal)
    puts "\n\n"
    
    print "[1] POSSUI CADASTRO  |  [2] FAZER CADASTRO"
    decisao_cliente_cadastro = validar_entrada(2)
    if decisao_cliente_cadastro == 1
        while true do
            puts "LOGIN"
            print "SEU E-MAIL: "
            e_mail_cliente = gets.chomp.strip
            senha_cliente = gets.chomp.strip
            cliente = carregar_dados_cliente(e_mail_cliente,senha_cliente)
            if cliente == []
                puts "SEU E-MAIL OU SENHA ESTÃO INCORRETOS!!!"
                next
            end 
        end 
        
    else
        cliente = fazer_cadastro
    end 
    

end 