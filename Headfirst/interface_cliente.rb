

def abrir_interface_cliente(estante)
    Gem.win_platform? ? (system "cls") : (system "clear")
    puts "\033[34;1m-=-" *4
    puts "\033[32;1mVATAPÁ STORE\033[m"
    puts "\033[34;1m-=-\033[m\033[m" *4
    print "\n\033[;1m[1] POSSUI CADASTRO  |  [2] FAZER CADASTRO: "
    decisao_cliente_cadastro = validar_entrada(2)
    if decisao_cliente_cadastro == 1
        while true do
            puts "\nLOGIN"
            print "SEU E-MAIL: "
            e_mail_cliente = gets.chomp.strip
            print "DIGITE SUA SENHA: \033[m"
            senha_cliente = gets.chomp.strip
            cliente = carregar_dados_cliente(e_mail_cliente,senha_cliente)
            if cliente == []
                puts "\033[31;1mSEU E-MAIL OU SENHA ESTÃO INCORRETOS!!!\033[m"
                next
            end 
            break
        end 
        
    else
        cliente = fazer_cadastro
    end

    Gem.win_platform? ? (system "cls") : (system "clear")
    # Cria o carrinho de compras
    carrinho = Carrinho.new
    puts "\033[34;1m-=-" *4
    puts "\033[32;1mVATAPÁ STORE\033[m"
    puts "\033[34;1m-=-\033[m" *4
    puts "Bem Vindo à maior loja de livros do Norte!\033[m"
    while true 
        print "\033[34;1m
[1] PROCURAR LIVRO POR TITULO [2] PROCURAR LIVRO POR AUTOR 
[3] PROCURAR LIVRO POR GÊNERO [4] PROCURAR LIVRO POR PAGINAS
[5] VOLTAR PARA PAGINA INICIAL\033[m

\033[;1mOPÇÃO: \033[m"
        decisao_cliente = validar_entrada (5)

        if decisao_cliente == 1 
            print "\033[1mINFORME O TÍTULO:\033[m"
            titulo_escolhido_cliente = gets.chomp.upcase.strip
            livros_filtrados = estante.filtrar(titulo_escolhido_cliente)
            if livros_filtrados == nil
                next
            end 
            carrinho.adicionar_carrinho(estante.selecionar_livros_desejados(livros_filtrados))
        elsif decisao_cliente == 2
            print "\033[;1mINFORME O AUTOR:\033[m"
            autor_escolhido_cliente = gets.chomp.upcase.strip
            livros_filtrados = estante.filtrar(autor_escolhido_cliente)
            if livros_filtrados == nil
                next
            end 
            carrinho.adicionar_carrinho(estante.selecionar_livros_desejados(livros_filtrados))
        elsif decisao_cliente == 3
            print "\033[;1mINFORME O GÊNERO:\033[m"
            genero_escolhido_cliente = gets.chomp.upcase.strip
            livros_filtrados = estante.filtrar(genero_escolhido_cliente)
            if livros_filtrados == nil
                next
            end 
            carrinho.adicionar_carrinho(estante.selecionar_livros_desejados(livros_filtrados))
        elsif decisao_cliente == 4
            livros_filtrados = estante.filtrar_por_paginas
            if livros_filtrados == nil
                next
            end 
            carrinho.adicionar_carrinho(estante.selecionar_livros_desejados(livros_filtrados))
        else
            break 
        end
        Gem.win_platform? ? (system "cls") : (system "clear")
        carrinho.mostrar_lista_compras
        carrinho.calcular_subtotal
        
        # Essa parte vai servir para finalizar as compras se o usuário quiser 
        
        print "\n\033[;1mVOCÊ DESEJA  [1 - ALTERAR O CARRINHO] [2 - CONTINUAR COMPRANDO] OU [3 - FINALIZAR COMPRA]: \033[m"
        decisao_cliente = validar_entrada(3)
        
        if decisao_cliente == 1
            sleep(0.5)
            carrinho.alterar_carrinho
            Gem.win_platform? ? (system "cls") : (system "clear")
            print "\n\033[;1mVOCÊ DESEJA [1 - CONTINUAR COMPRANDO] OU [2 - FINALIZAR COMPRA]: \033[m"
            decisao_cliente = validar_entrada(2)
            if decisao_cliente == 1
                next
            else
                finalizar_compras(cliente,carrinho)
            end 
        elsif decisao_cliente == 2
            next
        else
            finalizar_compras(cliente,carrinho)
        end 
    end 
end 
