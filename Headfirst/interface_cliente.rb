require "classes"

def abrir_interface_cliente
    puts "\nVATAPÁ STORE"
    puts "Bem Vindo à maior loja de livros do Norte!"
    while true 
        puts "\nVATAPÁ STORE"
        print "
[1] PROCURAR LIVRO POR TITULO [2] PROCURAR LIVRO POR AUTOR 
[3] PORCURAR LIVRO POR GÊNERO [4] PROCURAR LIVRO POR PAGINAS
[5] VOLTAR PARA PAGINA INICIAL

OPÇÃO:"
        opções = [1,2,3,4,5]    
        decisão_cliente = gets.chomp.to_i
        if not opções.include? decisão_cliente
            puts "OPÇÃO INVÁLIDA"
            puts "ESCOLHA ENTRE AS OPÇÕES VÁLIDAS [1 2 3 4 5]"
            next
        end 

        if decisão_cliente == 1 
            print "INFORME O TÍTULO:"
            titulo_escolhido_cliente = gets.chomp
            livro_desejado = estante.filtrar(titulo_escolhido_cliente)
            if livro_desejado.class == Livro
                print "DESEJA ADICIONAR O LIVRO NO CARRINHO [S] [N]: "
                if gets.chomp.upcase == "S"
                    carrinho.produtos << livro_desejado 
                    carrinho.mostrar
                    next
                end 
            end
        elsif decisão_cliente == 2
            estante.filtrar()
        elsif decisão_cliente == 3
            estante.filtrar()
        elsif decisão_cliente == 4
            estante.filtrar()
        else

        end

        # Essa parte vai servir para finlizar as compras se o usuário quiser 
        print "VOCẼ AINDA DESEJA FINALIZAR SUAS COMPRAS"
        if gets.chomp.upcase == "S"
            break
        end
    end 
end 

puts abrir_interface_cliente