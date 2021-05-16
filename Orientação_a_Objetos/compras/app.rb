require_relative 'mercado'
require_relative 'produto'



macarrao = Product.new("Macarrão",50.0)
mrkt_1 = Market.new(macarrao)
puts mrkt_1.buy