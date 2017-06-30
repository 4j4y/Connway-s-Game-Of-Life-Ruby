require './Cell.rb'
class World

	def initialize(w,h, lower, upper)
		@affectedCell = []
		@cell = []
		@width = w
		@height = h
		@underPopulation = lower
		@overPopulation  = upper
		@width.times do |i|
			@cell.push([])
			@height.times do |j|
				@cell[i].push(Cell.new(i, j, false))
			end	
		end
	end

	def setAlive(x, y, aliveOrDead)
		@cell[x][y].setAliveCell( aliveOrDead)
		@affectedCell.push(@cell[x][y])
	end

	def getNeighbours(x, y)
		neighbours = []
	  	neighbours.push(@cell[x-1][y-1]) if (x-1 >=0) && (y-1>= 0)
	  	neighbours.push(@cell[x][y-1]) 	 if (y-1>= 0)
	  	neighbours.push(@cell[x+1][y-1]) if (x<@width) && (y-1>=0)
	  	#puts "Upper : #{neighbours.length}"
	  	neighbours.push(@cell[x-1][y]) if (x-1 >=0 )  
	  	neighbours.push(@cell[x+1][y]) if (x+1<@width)
	  	#puts "Middle : #{neighbours.length}"
	  	neighbours.push(@cell[x-1][y+1]) if(x-1>=0) && (y+1<@height)
	  	neighbours.push(@cell[x][y+1])	 if(y+1<@height)
	  	neighbours.push(@cell[x+1][y+1]) if(x+1<@width) && (y+1<@height)
		#puts "Lower : #{neighbours.length}"
	  	return neighbours
	end
	
	def getAliveNeighbours(x, y)
		neighbours = getNeighbours(x, y)
		count = 0
		neighboursSize = neighbours.length 
		neighboursSize.times do |k|		
			count+=1 if (neighbours[k].isAlive? )	
		end
		return count
	end

	def nextGen()
		# Task 1: Add New Cells into new Affected Cell Gen
		newAffectedCell = []
		affectedCellSize = @affectedCell.length
		affectedCellSize.times do |i|
			neighbours =  getNeighbours(@affectedCell[i].getX, @affectedCell[i].getY)
			neighbourSize = neighbours.length
			neighbourSize.times do |j| 
				if (!neighbours[j].isAlive?)	
					countAliveNeighbours = getAliveNeighbours(neighbours[j].getX, neighbours[j].getY)
					if(countAliveNeighbours > @underPopulation && countAliveNeighbours < @overPopulation )
						newAffectedCell.push(neighbours[j])
					end
				end
			end
		end
		# Task 2: Add old livable cells into new Affected Generation
		deletedCell = 0
		affectedCellSize.times do |i|
			countAliveNeighbours = getAliveNeighbours(@affectedCell[i-deletedCell].getX, @affectedCell[i-deletedCell].getY)
			if(countAliveNeighbours > @underPopulation && countAliveNeighbours < @overPopulation )
				newAffectedCell.push(@affectedCell[i-deletedCell])
				@affectedCell.delete_at(i-deletedCell)
				deletedCell +=1	
			end				 
		end
		#Task 3: Set old dead Cells to dead 
		affectedCellSize = @affectedCell.length
		affectedCellSize.times do |i|
			@cell[@affectedCell[i].getX][@affectedCell[i].getY].setAliveCell(false)
		end

		# Task 4: Set new Affected cell as alive
		newAffectedCellSize =  newAffectedCell.length
		newAffectedCellSize.times do |i|
			@cell[newAffectedCell[i].getX][newAffectedCell[i].getY].setAliveCell(true)
		end

		# Task 5: Concat old alive cells to new Affected Cell
		@affectedCell = []
		@affectedCell.concat(newAffectedCell)
				
		return @affectedCell.uniq
	end
end
