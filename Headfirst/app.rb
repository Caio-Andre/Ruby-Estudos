require_relative 'classes'
require_relative 'funcoes'
require_relative 'interface_cliente'

# CRIA A ESTANTE DE LIVROS
estante = Estante.new(carregar_livros)


app = true 
while app do
  puts "\nVATAPÁ STORE"
  print"
[1] CLIENTE
[2] FUNCIONÁRIO VATAPÀ
[3] SAIR DA LOJA
SELECIONE UMA OPÇÂO:"
  decision = gets.chomp.to_i()
  if decision == 1
    abrir_interface_cliente(estante)
  elsif decision == 2
    adicionar_livros_banco_de_dados
  elsif decision == 3
    app = false
  end 
end 
















