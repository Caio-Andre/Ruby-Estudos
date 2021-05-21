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

def adicionar_livros_banco_de_dados ()
  genero = gets.chomp
  File.open("banco_de_dados.txt", "a") do |file|
    file.puts("#{genero}|#{livro_1.titulo}|#{livro_1.autor}|#{livro_1.paginas}|#{livro_1.preco}")
  end 
end 

# lER ESSE CARALHO

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














