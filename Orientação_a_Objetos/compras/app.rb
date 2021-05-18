class Produto 
    attr_reader :nome, :quantidade, :validade, :preco
    def initialize (nome, quantidade, validade, preco)
        @nome = nome 
        @quantidade = quantidade
        @validade = validade
        @preco = preco
    end
    def to_s
        "Nome: #{@nome}| Quantidade: #{@quantidade}| Validade: #{validade}| Preço: #{@preco}"
    end
end 
arroz = Produto.new("arroz", "1kg", "2 meses", 15.00)
class Mercado
    def initialize
    @@comidas = []
    end 

    def add_food_to_list (produto)
        @@comidas << produto
    end

    def mercado
        @@comidas
    end
end

markt = Mercado.new
markt.add_food_to_list(arroz)

puts markt.mercado

 








