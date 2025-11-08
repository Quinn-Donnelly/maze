class_name MazeWalls
extends TileMapLayer

@onready var mazeGenorator: DFSMazeGenerator = $DFSMazeGenorator
var winningLocation: Vector2i
var mazeBitArray: Array[Array]

## Generates the maze and renders on tilemap
func generate_maze() -> void:
	mazeBitArray = mazeGenorator.generate_dfs_maze(18-1,32-3)
	
	for row in mazeBitArray.size():
		for col in mazeBitArray[row].size():
			var cellCords = Vector2(4,3) if mazeBitArray[row][col] == 1 else Vector2(1,4)
			var worldRow = row * 2
			var worldCol = col * 2
			set_cell(Vector2(worldRow, worldCol), 0, cellCords) 
			set_cell(Vector2(worldRow+1, worldCol), 0, cellCords) 
			set_cell(Vector2(worldRow, worldCol+1), 0, cellCords) 
			set_cell(Vector2(worldRow+1, worldCol+1), 0, cellCords) 
			
	winningLocation = mazeGenorator.find_end_routes_greater_than(Vector2(1,1), mazeBitArray, 15).pick_random()
	winningLocation.x *= 2
	winningLocation.y *= 2

## Returns the global_position of winning location
func get_winning_location() -> Vector2:
	assert(winningLocation != null, "Must call generate_maze before calling for winning location")
	return to_global(map_to_local(winningLocation))

func get_all_end_routes(exclude_winning_route: bool = true) -> Array[Vector2]:
	var routes = mazeGenorator.find_end_routes_greater_than(Vector2(1,1), mazeBitArray, 1)
	var global_route_positions: Array[Vector2] = []
	for route in routes:
		route.x *= 2
		route.y *= 2
		
		if exclude_winning_route and route == winningLocation:
			continue
			
		global_route_positions.append(to_global(map_to_local(route)))
		
	return global_route_positions
