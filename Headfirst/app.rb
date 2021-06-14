require_relative 'classes'
require_relative 'interface_cliente'
require_relative 'interface_finalizar_compra'
require_relative 'cadastro'
require_relative 'interface_funcionário'

# CRIA A ESTANTE DE LIVROS
app = true
while app do
  Gem.win_platform? ? (system "cls") : (system "clear")
  puts "\033[34;1m-=-" *4
  puts "\033[32;1mVATAPÁ STORE\033[m"
  puts "\033[34;1m-=-\033[m" *4
  print"\033[34;1m
[1] CLIENTE
[2] FUNCIONÁRIO VATAPÁ
[3] SAIR DA LOJA

\033[;1mSELECIONE UMA OPÇÂO: \033[m"

  decision = validar_entrada(3)
  if decision == 1
    abrir_interface_cliente
  elsif decision == 2
    abrir_interface_funcionario
  elsif decision == 3
    app = false
  end 
end 




















