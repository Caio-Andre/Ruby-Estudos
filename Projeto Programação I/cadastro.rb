def fazer_cadastro 
    Gem.win_platform? ? (system "cls") : (system "clear")
    puts "\033[34;1m-=-" *4
    puts "\033[32;1mVATAPÁ STORE\033[m"
    puts "\033[34;1m-=-\033[m" *4
    puts "\nFAÇA O SEU CADASTRO"
    
    return carregar_dados_cliente(*adicionar_clientes_banco_de_dados)
end 