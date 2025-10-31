extends Node

@onready var health_componet: HealthComponent = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_componet.health_depleted.connect(self._on_health_depleted)

func _on_health_depleted() -> void:
	queue_free()
