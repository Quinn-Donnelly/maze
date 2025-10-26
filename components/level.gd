class_name Level
extends Node

## Camera used to show player when level power used
@export var levelCamera: Camera2D
@export var winningZone: PackedScene
@onready var mazeWalls: MazeWalls = $MazeWalls

func _ready() -> void:
	_create_winning_location(mazeWalls.get_winning_location())
	
func get_level_camera() -> Camera2D:
	return levelCamera

func _create_winning_location(globalLocation: Vector2) -> void:
	var winningInstance = winningZone.instantiate()
	winningInstance.global_position = globalLocation
	add_child(winningInstance)
