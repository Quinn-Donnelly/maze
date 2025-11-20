class_name RangeAttack
extends Node2D

@export var vision: AreaMonitor
@export var max_range: float = 200
@export var min_range: float = 10
@export var projectile_speed: float = 200
@export var projectile: PackedScene
@export var rangeSpawnPoint: Marker2D
@export var attackCooldown: Timer
@export_flags_2d_physics var visibilityCollisionMask

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
	# Need to filter the targets based on can see them
	var target: Node2D = targets.pick_random()
	_fire(target.global_position)

func _check_range(target_global_position: Vector2) -> Dictionary:
	var distance: float = (target_global_position - self.global_position).length()
	var positions_to_test = [
		target_global_position, 
		Vector2(target_global_position.x, target_global_position.y - 8),
		Vector2(target_global_position.x - 5, target_global_position.y),
		Vector2(target_global_position.x + 5, target_global_position.y),
	]
	var collider_visible = false
	var visible_point: Vector2 = Vector2()
	for pos in positions_to_test:
		var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(owner.global_position, pos, visibilityCollisionMask, [owner])
		var result: Dictionary = get_world_2d().direct_space_state.intersect_ray(query)
		if result and result["collider"] is Player:
			visible_point = pos
			collider_visible = true
			break
	
	var canSee: bool = collider_visible and distance <= max_range or distance < min_range
	return {"is_visible": canSee, "visible_point": visible_point}
	

func _fire(aimAt: Vector2) -> void:
	var visibilityInfo: Dictionary = _check_range(aimAt)
	if not visibilityInfo.is_visible:
		return
	
	var shot: Projectile = projectile.instantiate()
	shot.global_position = rangeSpawnPoint.global_position
	shot.velocity = (visibilityInfo.visible_point - global_position).normalized() * projectile_speed
	get_tree().current_scene.call_deferred("add_child", shot)
