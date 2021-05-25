require_relative 'classes'

def finalizar_compras(carrinho)
    carrinho.mostrar_lista_compras
    carrinho.calcular_subtotal
    puts "\nVOCÊ DESEJA ALTERAR O CARRINHO [1 - Sim] [2 - Não]: "
    decisao_cliente = validar_entrada(2)
    if decisao_cliente == 1
        carrinho.alterar_carrinho
    end 
    carrinho.mostrar_lista_compras
    # Testar funcao alterar carrinho 
    # Criar inteface de cadastro e frete (onde haja a possibilidade de retornar para o cadastro caso ele esteja errado)
    

end 