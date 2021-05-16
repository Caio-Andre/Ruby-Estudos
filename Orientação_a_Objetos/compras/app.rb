require_relative 'mercado'
require_relative 'produto'



macarrao = Product.new("Macarrão",50.0)
arroz = Product.new("Arroz",20.0)
mrkt_1 = Market.new(macarrao)
markt_2 = Market.new(arroz)
puts mrkt_1.buy
puts markt_2.buy
