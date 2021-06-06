def abrir_interface_funcionario(estante)
    Gem.win_platform? ? (system "cls") : (system "clear")
    
    arquivo = File.open("banco_de_dados_funcionarios.txt") do |file|
    dados_dos_funcionarios = arquivo.readlines
    arquivo.close
    
    funcionario = Funcionario.carregar_dados_dos_funcionarios(dados_dos_funcionarios)
    funcionario.logar

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
        
# ADICIONA NOVOS LIVROS NO BANCO
def adicionar_livros_banco_de_dados(estante)
    while true
      print "INFORME O TÍTULO DO LIVRO: "
      titulo = gets.chomp.strip.upcase
      livro_no_estoque = false 
      for livro in estante.livros 
          if livro.titulo == titulo
              puts "\nLIVRO JÁ EXISTENTE NO ESTOQUE" 
              livro_no_estoque = true
              break
          end 
      end 
      if livro_no_estoque == false
        id = gerar_id_disponível(estante)
        print "INFORME O GENÊRO DO LIVRO: "
        genero = gets.chomp.upcase
        print "INFORME O AUTOR DO LIVRO: "
        autor = gets.chomp.upcase
        print "INFORME O NÚMERO DE PÁGINAS DO LIVRO: "
        paginas = gets.chomp.to_i
        print "INFORME O PREÇO DO LIVRO: "
        preco = gets.chomp.to_f
  
        File.open("banco_de_dados_livros.txt", "a") do |arquivo|
          arquivo.puts("#{id}|#{genero}|#{titulo}|#{autor}|#{paginas}|#{preco}")
        end
        puts "LIVRO ADICIONADO COM SUCESSO!"
      end 
      puts "\nVOCÊ DESEJA ADICIONAR UM LIVRO DIFERENTE [Sim - 1] [Não - 2]: "
      decisao_funcionario = validar_entrada(2)
      if decisao_funcionario == 2
        break
      end
    end
  end 
  
def remover_livros_banco_de_dados(estante)
    while true do
      print "INDIQUE UMA INFORMAÇÃO DO LIVRO A SER REMOVIDO(Título/Gênero/Autor): "
      filtro = gets.chomp.strip.upcase
      livros_a_serem_removidos = estante.filtrar(filtro)
      if livros_a_serem_removidos != nil
        puts livros_a_serem_removidos
      else
        print "\nVOCÊ DESEJA PROCURAR POR OUTRO LIVRO [Sim - 1][Não - 2]: "
        decisao_funcionario = validar_entrada(2)
        if decisao_funcionario == 1
          next
        else
          break
        end 
      end  
      print "INFORME O ID DO LIVRO A SER REMOVIDO: "
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
      print "VOCÊ QUER REMOVER OUTRO LIVRO: [Sim - 1] [Não - 2]: "
      decisao_funcionario = validar_entrada(2)
      if decisao_funcionario == 1
        next
      else
        break
      end 
    end 
      
end 