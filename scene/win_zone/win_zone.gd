class_name WinZone
extends Area2D

func _ready() -> void:
	body_entered.connect(self._on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		EventBus.player_win_zone.emit()	
	
