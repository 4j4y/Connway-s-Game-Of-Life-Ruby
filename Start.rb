require './Cell.rb'
require './World.rb'

world = World.new(250, 250, 2, 6)
world.setAlive(0,0, true)
world.setAlive(0,1, true)
world.setAlive(1,0, true)
world.setAlive(1,2, true)
gen1 = world.nextGen()
gen1Size = gen1.length
puts "#{gen1Size}"
gen1Size.times do |i|
puts "X: #{gen1[i].getX}   Y: #{gen1[i].getY}"
end

