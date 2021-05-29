

def abrir_interface_cliente(estante)
    Gem.win_platform? ? (system "cls") : (system "clear")
    # Cria o carrinho de compras
    carrinho = Carrinho.new
    puts "\n\nVATAPÁ STORE"
    puts "Bem Vindo à maior loja de livros do Norte!"
    while true 
        puts "\nVATAPÁ STORE"
        print "
[1] PROCURAR LIVRO POR TITULO [2] PROCURAR LIVRO POR AUTOR 
[3] PROCURAR LIVRO POR GÊNERO [4] PROCURAR LIVRO POR PAGINAS
[5] VOLTAR PARA PAGINA INICIAL

OPÇÃO: "
        decisao_cliente = validar_entrada (5)

        if decisao_cliente == 1 
            print "INFORME O TÍTULO:"
            titulo_escolhido_cliente = gets.chomp.upcase.strip
            livros_filtrados = estante.filtrar(titulo_escolhido_cliente)
            if livros_filtrados == nil
                next
            end 
            carrinho.adicionar_carrinho(estante.selecionar_livros_desejados(livros_filtrados))
        elsif decisao_cliente == 2
            print "INFORME O AUTOR:"
            autor_escolhido_cliente = gets.chomp.upcase.strip
            livros_filtrados = estante.filtrar(autor_escolhido_cliente)
            if livros_filtrados == nil
                next
            end 
            carrinho.adicionar_carrinho(estante.selecionar_livros_desejados(livros_filtrados))
        elsif decisao_cliente == 3
            print "INFORME O GÊNERO:"
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

        carrinho.mostrar_lista_compras
        carrinho.calcular_subtotal
       
        # Essa parte vai servir para finalizar as compras se o usuário quiser 
        print "\nVOCÊ DESEJA  [1 - ALTERAR O CARRINHO] [2 - CONTINUAR COMPRANDO] OU [3 - FINALIZAR COMPRA] : "
        decisao_cliente = validar_entrada(3)
        
        if decisao_cliente == 1
            carrinho.alterar_carrinho
            print "\nVOCÊ DESEJA [1 - CONTINUAR COMPRANDO] OU [2 - FINALIZAR COMPRA] : "
            decisao_cliente = validar_entrada(2)
            if decisao_cliente == 1
                next
            else
                finalizar_compras(carrinho)
            end 
        elsif decisao_cliente == 2
            next
        else
            finalizar_compras(carrinho)
        end 
    end 
end 
