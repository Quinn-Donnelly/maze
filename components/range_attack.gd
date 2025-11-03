class_name RangeAttack
extends Node2D

@export var vision: AreaMonitor
@export var max_range: float = 200
@export var min_range: float = 10
@export var projectile_speed: float = 200
@export var projectile: PackedScene
@export var rangeSpawnPoint: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vision.area_entered.connect(self._on_vision_area_entered)

func _on_vision_area_entered(area: Area2D) -> void:
	var distance: float = (area.global_position - self.global_position).length()
	if distance > max_range or distance < min_range:
		return
	
	print("Hit em where it hurts")
	_fire(area.global_position)

func _fire(aimAt: Vector2) -> void:
	var shot: Projectile = projectile.instantiate()
	shot.global_position = rangeSpawnPoint.global_position
	shot.velocity = (aimAt - global_position).normalized() * projectile_speed
	get_tree().current_scene.call_deferred("add_child", shot)
