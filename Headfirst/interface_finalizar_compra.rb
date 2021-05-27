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
    cadastro
    # Criar inteface de cadastro (onde haja a possibilidade de retornar para o cadastro caso ele esteja errado)

end 