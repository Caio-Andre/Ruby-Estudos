require_relative 'classes'

# HAS CHANGED
def finalizar_compras(cliente,carrinho)
    
    #HERE
    puts "\n\n"
    total = calcular_valor_final(carrinho.calcular_desconto(cliente))

    escolher_forma_de_pagamento(total)

    print "\n\033[;1mVOCÊ DESEJA  [1 - CONFIRMAR COMPRA] [2 - SAIR DA LOJA] : \033[34;1m"
    decisao_cliente = validar_entrada(2)
    
    if decisao_cliente == 1   
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

    ## REFATORAR CÓDIGO (Class Cliente - ADICIONAR NA FUNCAO DE CRIAR CADASTRO A FUNCAO DE CRIAR OBJETO CLIENTE) / COMENTAR CODIGO / CONCERTAR PRINTS DO CADASTRO E DOS PAGAMENTOS /ADIOCIONAR LIVROS / 
end 