def abrir_interface_funcionario(estante)
    while true 
        print "\nVOCÊ DESEJA ADICIONAR OU REMOVER ALGUM LIVRO [Adicionar - 1] [Remover - 2] [Sair - 3]: "
        decisao_funcionario = validar_entrada(2)

        if decisao_funcionario == 1
            adicionar_livros_banco_de_dados(estante)  
        elsif idecisao_funcionario == 2

        else  
            break 
        end 
    end 
        