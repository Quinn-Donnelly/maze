extends Node

@onready var dfs: DFSMazeGenerator = $DFS

func _ready() -> void:
	print(dfs.generate_dfs_maze(20, 20))

func get_current_level() -> Level:
	return get_tree().current_scene as Level
