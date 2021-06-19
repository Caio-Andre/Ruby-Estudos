require_relative 'classes'

# DIRECIONA O CLIENTE PARA A INTERFACE DE FINALIZAR A COMPRA
def finalizar_compras(cliente,carrinho)
    finalizador_de_compras = Finalizador_de_Compra.new
   
    puts "\n\n"
    total = carrinho.calcular_valor_final(cliente)

    finalizador_de_compras.escolher_forma_de_pagamento(total)


    print "\n\n\033[;1mVOCÊ DESEJA  [1 - CONFIRMAR COMPRA] [2 - SAIR DA LOJA] : \033[34;1m"
    decisao_cliente = validar_entrada(2)
    
    if decisao_cliente == 1   
        cliente.atualizar_desconto_do_cliente
        sleep(0.5)
        Gem.win_platform? ? (system "cls") : (system "clear")
        puts "\033[34;1m-=-" *4
        puts "\033[32;1mVATAPÁ STORE\033[m"
        puts "\033[34;1m-=-\033[m\033[m" *4
        puts "\033[34;1mOBRIGRADO POR COMPRAR NA NOSSA LOJA!\033[m"
        puts "\033[32;1mCOMPRA FINALIZADA\033[m"
        exit()
    else 
        exit()
    end 

    # ADIOCIONAR LIVROS / ADICIONAR VALIDACAO PARA O CARTAO DE CRIEDITO 
end 