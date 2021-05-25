# LER OS LIVROS DO BANCO DE DADOS E CRIA OBJETOS DA CLASSE LIVROS. 

def carregar_livros
  livros = []
  File.open("banco_de_dados.txt") do |file|
    file.each do |line| 
      id, genero, titulo, autor, paginas, precos = line.chomp.split("|")
      livros << Livro.new(id.to_i, genero, titulo, autor, paginas.to_i, precos.to_f)
    end 
  end
  return livros
end


# ADICIONA NOVOS LIVROS NO BANCO

def adicionar_livros_banco_de_dados
  while true
    print "Por favor, informe o id do livro:"
    id = gets.chomp.to_i
    print "Por favor, informe o gênero do livro:"
    genero = gets.chomp
    print "Por favor, informe o título do livro:"
    titulo = gets.chomp
    print "Por favor, informe o autor do livro:"
    autor = gets.chomp
    print "Por favor, informe o número de páginas do livro:"
    paginas = gets.chomp.to_i
    print "Por favor, informe o preço do livro:"
    preco = gets.chomp.to_f

    File.open("banco_de_dados.txt", "a") do |arquivo|
      arquivo.puts("#{id}|#{genero}|#{titulo}|#{autor}|#{paginas}|#{preco}")
    end
    
    puts "Livro adicionado com sucesso!"
    puts "Você deseja adicionar mais livros?"
    puts "Se você não deseja adicionar mais livros, digite 'N'."
    if gets.chomp.upcase == 'N'
      break
    end
  end
end 


def validar_entrada (numero_de_opcoes_validas) 
  opções = (1..numero_de_opcoes_validas).to_a
  escolha_usuario = gets.chomp.strip.to_i
  while true do   
    if opções.include? escolha_usuario
        return escolha_usuario

    else
      puts "\nOPÇÃO INVÁLIDA"
      print "ESCOLHA ENTRE AS OPÇÕES VÁLIDAS #{opções}: "
      escolha_usuario = gets.chomp.strip.to_i
    end 
  end 
end 



