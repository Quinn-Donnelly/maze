class_name DFSMazeGenerator
extends Node

var directions: Array[Vector2] = [Vector2(0,-2), Vector2(2,0), Vector2(0,2), Vector2(-2,0)]

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
		directions.shuffle()
		for dir in directions:
			if current.x + dir.x >= height || current.x + dir.x <= 0 || current.y + dir.y <= 0 || current.y + dir.y >= width || grid[current.x + dir.x][current.y + dir.y] == 0:
				continue
			stack.push_front(current)
			grid[current.x + dir.x / 2][current.y + dir.y / 2] = 0
			grid[current.x + dir.x][current.y + dir.y] = 0
			current.x += dir.x
			current.y += dir.y
			stack.push_front(current)
			
	return grid

func pretty_print_2d_array(array: Array[Array]) -> void:
	for row in array:
		var row_string = ""
		for n in row:
			row_string += "%d," % n
		row_string = row_string.erase(row_string.length()-1)
		print(row_string)
