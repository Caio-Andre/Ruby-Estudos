require_relative 'class_livro'
require_relative 'class_estante'

# ADICIONA NOVOS LIVROS NO BANCO
def adicionar_livros_banco_de_dados
  while true
    print "Por favor, informe o gênero do livro:"
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

    if genero.class == String && titulo.class == String

    File.open("banco_de_dados.txt", "a") do |arquivo|
      arquivo.puts("#{genero}|#{titulo}|#{autor}|#{paginas}|#{preco}")
    end
    
    puts "Livro adicionado com sucesso"
    puts "Você deseja adicionar mais livros?"
    puts "Se você não deseja adicionar mais livros, digite 'N'."
    if gets.chomp.upcase == 'N'
      break
    end
  end
end 


# Ler os livros do banco de dados e cria objetos da class Livros. 

def carregar_livros
  estante = []
  File.open("banco_de_dados.txt") do |file|
    file.each do |line| 
      id, genero, titulo, autor, paginas, precos = line.chomp.split("|")
      estante << Livro.new(id, genero, titulo, autor, paginas.to_i, precos.to_f)
    end 
  end 
  return estante
end
puts "#{carregar_livros}"














