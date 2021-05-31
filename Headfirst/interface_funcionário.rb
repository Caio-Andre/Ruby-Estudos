def abrir_interface_funcionario(estante)
    while true 
        print "\nVOCÊ DESEJA ADICIONAR OU REMOVER ALGUM LIVRO [Adicionar - 1] [Remover - 2] [Sair - 3]: "
        decisao_funcionario = validar_entrada(3)
    
        if decisao_funcionario == 1
            adicionar_livros_banco_de_dados(estante)  
        elsif decisao_funcionario == 2
            remover_livros_banco_de_dados(estante)
        else  
            break 
        end 
    end 
end 
        