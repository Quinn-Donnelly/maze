class_name RangeAttack
extends Node2D

@export var vision: AreaMonitor
@export var max_range: float = 200
@export var min_range: float = 10
@export var projectile_speed: float = 200
@export var projectile: PackedScene
@export var rangeSpawnPoint: Marker2D
@export var attackCooldown: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vision.area_occupied.connect(self._on_area_occupied)
	vision.area_empty.connect(self._on_area_empty)
	attackCooldown.timeout.connect(self._on_attack_cooldown_timeout)

func _on_area_occupied() -> void:
	attackCooldown.start()
	_fire(vision.get_areas_inside().pick_random().global_position)

func _on_area_empty() -> void:
	attackCooldown.stop()

func _on_attack_cooldown_timeout() -> void:
	var targets: Array[Node2D] = vision.get_areas_inside()
	if targets.size() == 0:
		return
	
	var target: Node2D = targets.pick_random()
	_fire(target.global_position)

func _check_range(target_global_position: Vector2) -> bool:
	var distance: float = (target_global_position - self.global_position).length()
	return distance <= max_range or distance < min_range

func _fire(aimAt: Vector2) -> void:
	_check_range(aimAt)
	var shot: Projectile = projectile.instantiate()
	shot.global_position = rangeSpawnPoint.global_position
	shot.velocity = (aimAt - global_position).normalized() * projectile_speed
	get_tree().current_scene.call_deferred("add_child", shot)
