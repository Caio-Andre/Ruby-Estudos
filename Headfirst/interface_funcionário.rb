def abrir_interface_funcionario
    Gem.win_platform? ? (system "cls") : (system "clear")

    estante = Estante.new(carregar_livros)
    
    Funcionario.logar.registrar_entrada_do_funcionario

    while true 
      Gem.win_platform? ? (system "cls") : (system "clear")
        print "\n\033[34;1mVOCÊ DESEJA ADICIONAR OU REMOVER ALGUM LIVRO [Adicionar - 1] [Remover - 2] [Sair - 3]: \033[m"
        decisao_funcionario = validar_entrada(3)
        if decisao_funcionario == 1
            adicionar_livros_banco_de_dados(estante)
            estante.livros = carregar_livros  
        elsif decisao_funcionario == 2
            remover_livros_banco_de_dados(estante)
            estante.livros = carregar_livros
        else  
            break 
        end 
    end 
end 
        
# ADICIONA NOVOS LIVROS NO BANCO
def adicionar_livros_banco_de_dados(estante)
  Gem.win_platform? ? (system "cls") : (system "clear")
    while true
      print "\n\033[;1mINFORME O TÍTULO DO LIVRO: \033[m"
      titulo = gets.chomp.strip.upcase
      livro_no_estoque = false 
      for livro in estante.livros 
          if livro.titulo == titulo
              puts "\n\033[;1mLIVRO JÁ EXISTENTE NO ESTOQUE\033[m" 
              livro_no_estoque = true
              break
          end 
      end 
      if livro_no_estoque == false
        id = gerar_id_disponível(estante)
        print "\033[;1mINFORME O GENÊRO DO LIVRO: \033[m"
        genero = gets.chomp.upcase
        print "\033[;1mINFORME O AUTOR DO LIVRO: \033[m"
        autor = gets.chomp.upcase
        print "\033[;1mINFORME O NÚMERO DE PÁGINAS DO LIVRO: \033[m"
        paginas = gets.chomp.to_i
        print "\033[;1mINFORME O PREÇO DO LIVRO: \033[m"
        preco = gets.chomp.to_f
  
        File.open("banco_de_dados_livros.txt", "a") do |arquivo|
          arquivo.puts("#{id}|#{genero}|#{titulo}|#{autor}|#{paginas}|#{preco}")
        end
        puts "\n\033[32;1mLIVRO ADICIONADO COM SUCESSO!\033[m"
      end 
      puts "\n\033[;1mVOCÊ DESEJA ADICIONAR UM LIVRO DIFERENTE [Sim - 1] [Não - 2]: \033[m"
      decisao_funcionario = validar_entrada(2)
      if decisao_funcionario == 2
        break
      end
    end
  end 
  
def remover_livros_banco_de_dados(estante)
  Gem.win_platform? ? (system "cls") : (system "clear")
    while true do
      print "\033[;1mINDIQUE UMA INFORMAÇÃO DO LIVRO A SER REMOVIDO(Título/Gênero/Autor): "
      filtro = gets.chomp.strip.upcase
      livros_a_serem_removidos = estante.filtrar(filtro)
      if livros_a_serem_removidos != nil
        puts livros_a_serem_removidos
      else
        print "\n\033[;1mVOCÊ DESEJA PROCURAR POR OUTRO LIVRO [Sim - 1][Não - 2]: \033[m"
        decisao_funcionario = validar_entrada(2)
        if decisao_funcionario == 1
          next
        else
          break
        end 
      end  
      print "\n\033[;1mINFORME O ID DO LIVRO A SER REMOVIDO: \033[m"
      id = gets.chomp.to_i
      for livro in estante.livros
        if livro.id == id 
          estante.livros.delete(livro)
          puts 
        end 
      end 
      puts estante.livros
        File.open("banco_de_dados_livros.txt", "w") do |arquivo|
        end
      for livro in estante.livros
        File.open("banco_de_dados_livros.txt", "a") do |arquivo|
          arquivo.puts("#{livro.id}|#{livro.genero}|#{livro.titulo}|#{livro.autor}|#{livro.paginas}|#{livro.preco}")
        end
      end 
      print "\n\033[;1mVOCÊ QUER REMOVER OUTRO LIVRO: [Sim - 1] [Não - 2]: \033[m"
      decisao_funcionario = validar_entrada(2)
      if decisao_funcionario == 1
        next
      else
        break
      end 
    end 
end 