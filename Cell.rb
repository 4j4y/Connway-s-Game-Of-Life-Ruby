class Cell
	#attr_accessor :positionX, :positionY, :alive
	
	def initialize(x, y, aliveOrDead)
		@positionX = x
		@positionY = y
		@alive = aliveOrDead
	end

	def getX()
		@positionX
	end
	
	def getY()
		@positionY
	end

	def	isAlive()
		@alive
	end

	def setAliveCell(aliveOrDead)
		@alive = aliveOrDead
	end 

end

