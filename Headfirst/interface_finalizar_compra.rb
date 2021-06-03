require_relative 'classes'

# HAS CHANGED
def finalizar_compras(cliente,carrinho)
    
    #HERE
    puts "\n\n"
    total = calcular_valor_final(carrinho.calcular_desconto(cliente))

    escolher_forma_de_pagamento(total)

    puts "\033[34;1m-=-" *4
    puts "\033[32;1mVATAPÁ STORE\033[m"
    puts "\033[34;1m-=-\033[m\033[m" *4
    print "\n\033[;1mVOCÊ DESEJA  [1 - CONFIRMAR COMPRA] [2 - SAIR DA LOJA] : \033[34;1m"
    decisao_cliente = validar_entrada(2)
    if decisao_cliente == 1   
        puts "\033[34;1mOBRIGRADO POR COMPRAR NA NOSSA LOJA!\033[m"
        puts "\033[32;1mCOMPRA FINALIZADA\033[32;1m"
        app = false
    else 
        app = false
    end 

    ## CONSTRUIR PAGAMENTO POR BOLETO/ ADIOCIONAR SESSÃO DE LOGIN PARA O FUNCIONARIO/ ADIOCIONAR COR PARA A INTERFACE FUNCIONARIO. / ADIOCIONAR LIVROS / COMENTAR CODIGO
end 