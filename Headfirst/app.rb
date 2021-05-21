require_relative 'class_livro'
require_relative 'class_estante'


def adicionar_livros_banco_de_dados ()
  genero = gets.chomp
  File.open("banco_de_dados.txt", "a") do |file|
    file.puts("#{genero}|#{livro_1.titulo}|#{livro_1.autor}|#{livro_1.paginas}|#{livro_1.preco}")
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














