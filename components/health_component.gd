class_name HealthComponent
extends Node

signal health_depleted

@export var max_health: int = 5
var current_health: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().set_meta(Constants.HEALTH_COMPONENT, self)
	current_health = max_health

func get_current_health() -> int:
	return current_health

func take_damage(damage_amount: int) -> int:
	current_health -= damage_amount
	if current_health <= 0:
		health_depleted.emit()
	return clamp(current_health, 0, INF)
