class_name KillZone
extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_exited.connect(self._on_area_exited)
	body_exited.connect(self._on_body_exited)

func _on_area_exited(area: Area2D) -> void:
	area.queue_free()
	
func _on_body_exited(body: Node2D) -> void:
	body.queue_free()
