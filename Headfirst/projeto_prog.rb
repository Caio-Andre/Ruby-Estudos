require_relative 'class_livro'

class Estante
  def initialize
      @livros = []
  end

  def filtrar 
    
  end

  def mostrar_livros_guardados
      puts "\n"
      @livros.each_key {|categoria|
        for livro in @livros[categoria]
          puts livro
        end
      }
  end

  def mostrar_livros_da_categoria categoria
    if @livros.has_key?categoria
      for livro in @livros[categoria]
        puts livro
      end
    else
      puts "Esta categoria não possui livros nesta biblioteca"
    end
  end
end

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

# LER OS LIVROS DA ESTANTE

def carregar_livros
  estante = []
  File.open("banco_de_dados.txt") do |file|
    file.each do |line| 
      genero, titulo, autor, paginas, precos = line.chomp.split("|")
      estante << Livro.new(genero, titulo, autor, paginas.to_i, precos.to_f)
    end 
  end 
  return estante
end
puts "#{carregar_livros}"














