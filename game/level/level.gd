class_name Level
extends Node

## Camera used to show player when level power used
@export var levelCamera: Camera2D
@export var winningZone: PackedScene
## For locations which are valid ends but not chosen I'll spawn in randomly from here
@export var supriseScenes: Array[PackedScene]
@onready var mazeWalls: MazeWalls = $MazeWalls
@onready var fog: Fog = $FogOfWar
@onready var player: Player = $Player
@onready var spawnLocation: Marker2D = $PlayerSpawnLocation

const maze_group = "maze_instances"

func _ready() -> void:
	start_level()
	EventBus.play_again.connect(self._on_play_again)
	
func get_level_camera() -> Camera2D:
	return levelCamera

func start_level() -> void:	
	player.global_position = spawnLocation.global_position
	if mazeWalls:
		mazeWalls.generate_maze()
		_create_scene_at_location(mazeWalls.get_winning_location(), winningZone)
		_generate_suprises()
	if fog:
		fog.generate_fog()

func _generate_suprises() -> void:
	if supriseScenes.is_empty():
		return
	var locations: Array[Vector2] = mazeWalls.get_all_end_routes()
	for location in locations:
		_create_scene_at_location(location, supriseScenes.pick_random())

func _create_scene_at_location(globalLocation: Vector2, scene: PackedScene) -> void:
	var instance = scene.instantiate()
	instance.global_position = globalLocation
	instance.add_to_group(maze_group)
	add_child(instance)

func _free_maze_group() -> void:
	get_tree().call_group(maze_group, "queue_free")

func _on_play_again() -> void:
	_free_maze_group()
	start_level()
