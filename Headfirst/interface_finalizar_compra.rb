require_relative 'classes'

# HAS CHANGED
def finalizar_compras(carrinho)
    
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