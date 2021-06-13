def abrir_interface_funcionario
    Gem.win_platform? ? (system "cls") : (system "clear")

    estante = Estante.new
    estante.carregar_livros
    
    funcionario = Funcionario.logar
    funcionario.registrar_entrada_do_funcionario

    while true 
      Gem.win_platform? ? (system "cls") : (system "clear")
        print "\n\033[34;1mVOCÊ DESEJA ADICIONAR OU REMOVER ALGUM LIVRO [Adicionar - 1] [Remover - 2] [Sair - 3]: \033[m"
        decisao_funcionario = validar_entrada(3)
        if decisao_funcionario == 1
            funcionario.adicionar_livros_banco_de_dados(estante)
            estante.carregar_livros  
        elsif decisao_funcionario == 2
            funcionario.remover_livros_banco_de_dados(estante)
            estante.carregar_livros
        else  
            break 
        end 
    end 
end 

