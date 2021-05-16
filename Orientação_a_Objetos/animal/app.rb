require_relative 'animal'
require_relative 'cachorro'

animal = Animal.new
puts animal.pular()
puts animal.dormir()

dog = Cachorro.new
puts dog.pular
puts dog.latir