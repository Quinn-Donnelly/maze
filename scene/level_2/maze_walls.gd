class_name MazeWalls
extends TileMapLayer

@onready var mazeGenorator: DFSMazeGenerator = $DFSMazeGenorator

func _ready() -> void:
	var mazeBitArray: Array[Array] = mazeGenorator.generate_dfs_maze(18-1,32-3)
	
	for row in mazeBitArray.size():
		for col in mazeBitArray[row].size():
			var cellCords = Vector2(4,3) if mazeBitArray[row][col] == 1 else Vector2(1,4)
			set_cell(Vector2(row, col), 0, cellCords)
