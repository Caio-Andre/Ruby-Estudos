require_relative 'classes'
require_relative 'funcoes'
require_relative 'interface_cliente'
require_relative 'interface_finalizar_compra'
require_relative 'cadastro'


# CRIA A ESTANTE DE LIVROS
estante = Estante.new(carregar_livros)

=begin
app = true 
while app do
  puts "\nVATAPÁ STORE"
  print"
[1] CLIENTE
[2] FUNCIONÁRIO VATAPÀ
[3] SAIR DA LOJA
SELECIONE UMA OPÇÂO:"

  decision = validar_entrada(3)
  if decision == 1
    abrir_interface_cliente(estante)
  elsif decision == 2
    adicionar_livros_banco_de_dados
  elsif decision == 3
    app = false
  end 
end 
=end 

















