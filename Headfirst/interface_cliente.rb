require_relative "classes"

def abrir_interface_cliente(estante)
    puts "\nVATAPÁ STORE"
    puts "Bem Vindo à maior loja de livros do Norte!"
    while true 
        puts "\nVATAPÁ STORE"
        print "
[1] PROCURAR LIVRO POR TITULO [2] PROCURAR LIVRO POR AUTOR 
[3] PORCURAR LIVRO POR GÊNERO [4] PROCURAR LIVRO POR PAGINAS
[5] VOLTAR PARA PAGINA INICIAL

OPÇÃO: "
        
        decisao_cliente = validar_entrada (5)

        if decisao_cliente == 1 
            print "INFORME O TÍTULO:"
            titulo_escolhido_cliente = gets.chomp.upcase.strip
            livros_desejados = estante.filtrar(titulo_escolhido_cliente)
            if livro_desejado.class == Livro
                print "DESEJA ADICIONAR O LIVRO NO CARRINHO [S] [N]: "
                if gets.chomp.upcase == "S"
                    carrinho.produtos << livros_desejados 
                    carrinho.mostrar
                    next
                end 
            end
        elsif decisao_cliente == 2
            print "INFORME O AUTOR:"
            autor_escolhido_cliente = gets.chomp.upcase.strip
            livros_desejados = estante.filtrar(autor_escolhido_cliente)
        elsif decisao_cliente == 3
            print "INFORME O GÊNERO:"
            genero_escolhido_cliente = gets.chomp.upcase.strip
            livros_desejados = estante.filtrar(genero_escolhido_cliente)
        elsif decisao_cliente == 4
            estante.filtrar_por_paginas
        else
            # CONTINUAR ###### DECISAO PARA VOLTAR PARA TELA DE INICIO
        end

        # Essa parte vai servir para finlizar as compras se o usuário quiser 
        print "\n VOCẼ DESEJA FINALIZAR SUAS COMPRAS [S] [N]: "
        if gets.chomp.upcase == "S"
            break
        end
    end 
end 
