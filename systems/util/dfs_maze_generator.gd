class_name DFSMazeGenerator
extends Node

var directionsDoubleStep: Array[Vector2] = [Vector2(0,-2), Vector2(2,0), Vector2(0,2), Vector2(-2,0)]
var directionsSingleStep: Array[Vector2] = [Vector2(0,-1), Vector2(1,0), Vector2(0,1), Vector2(-1,0)]

func generate_dfs_maze(width: int, height: int) -> Array:
	var grid: Array[Array] = []
	for row in range(height + 1):
		var currentRow: Array[int] = []
		currentRow.resize(width + 1)
		currentRow.fill(1)
		grid.append(currentRow)

	var stack = []
	var row = 1
	var col = 1
	grid[row][col] = 0
	stack.push_front(Vector2(row, col))
	
	var current
	while stack.size() > 0:
		current = stack.pop_front()
		directionsDoubleStep.shuffle()
		for dir in directionsDoubleStep:
			if current.x + dir.x >= height || current.x + dir.x <= 0 || current.y + dir.y <= 0 || current.y + dir.y >= width || grid[current.x + dir.x][current.y + dir.y] == 0:
				continue
			stack.push_front(current)
			grid[current.x + dir.x / 2][current.y + dir.y / 2] = 0
			grid[current.x + dir.x][current.y + dir.y] = 0
			current.x += dir.x
			current.y += dir.y
			stack.push_front(current)
			
	return grid

func find_end_routes_greater_than(starting_location: Vector2i, grid: Array[Array],distance: int) -> Array[Vector2i]:
	assert(grid.size() >= 1, "Must pass in a grid larger than one row")
	var height: int = grid.size()
	var width: int = grid[0].size()
	var stack: Array[Dictionary] = []
	var current: Dictionary
	var options: Array[Vector2i] = []
	var visited: Dictionary[Vector2i, bool] = {}
	
	stack.push_front({"location": starting_location, "distance": 0})
	while stack.size() > 0:
		current = stack.pop_front()
		visited[current["location"]] = true
		var hadChildren = false
		for dir in directionsSingleStep:
			if current["location"].x + dir.x >= height || current["location"].x + dir.x <= 0 || current["location"].y + dir.y <= 0 || current["location"].y + dir.y >= width || grid[current["location"].x + dir.x][current["location"].y + dir.y] == 1:
				continue
			var nextLocation: Vector2i = Vector2i(current["location"].x + dir.x, current["location"].y + dir.y)
			if not visited.get(nextLocation):
				stack.push_back({"location": nextLocation, "distance": current["distance"] + 1})
				hadChildren = true
		
		if not hadChildren and current["distance"] > distance:
			options.append(current["location"])
	
	return options
	

func pretty_print_2d_array(array: Array[Array]) -> void:
	for row in array:
		var row_string = ""
		for n in row:
			row_string += "%d," % n
		row_string = row_string.erase(row_string.length()-1)
		print(row_string)
