class_name Level
extends Node

## Camera used to show player when level power used
@export var levelCamera: Camera2D
@export var winningZone: PackedScene
@onready var mazeWalls: MazeWalls = $MazeWalls
@onready var fog: Fog = $FogOfWar
@onready var player: Player = $Player
@onready var spawnLocation: Marker2D = $PlayerSpawnLocation

var currentWinZone: WinZone

func _ready() -> void:
	start_level()
	EventBus.play_again.connect(self._on_play_again)
	
func get_level_camera() -> Camera2D:
	return levelCamera

func start_level() -> void:
	if currentWinZone != null:
		currentWinZone.queue_free()
	
	player.global_position = spawnLocation.global_position
	mazeWalls.generate_maze()
	fog.generate_fog()
	_create_winning_location(mazeWalls.get_winning_location())

func _create_winning_location(globalLocation: Vector2) -> void:
	currentWinZone = winningZone.instantiate()
	currentWinZone.global_position = globalLocation
	add_child(currentWinZone)

func _on_play_again() -> void:
	start_level()
