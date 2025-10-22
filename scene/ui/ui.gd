class_name UI
extends CanvasLayer

@onready var gameWinLabel: Label = $GameWinLabel

func _ready() -> void:
	_reset()
	EventBus.player_win_zone.connect(self._on_player_win_zone)

func _reset() -> void:
	gameWinLabel.hide()

func _on_player_win_zone() -> void:
	gameWinLabel.show()
