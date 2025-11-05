class_name UI
extends CanvasLayer

@onready var gameWinLabel: Label = $GameWinLabel
@onready var playAgainButton: Button = $PlayAgainButton

func _ready() -> void:
	_reset()
	EventBus.player_win_zone.connect(self._on_player_win_zone)
	playAgainButton.pressed.connect(self._on_play_again)

func _reset() -> void:
	gameWinLabel.hide()
	playAgainButton.hide()

func _on_player_win_zone() -> void:
	gameWinLabel.show()
	playAgainButton.show()

func _on_play_again() -> void:
	EventBus.play_again.emit()
	_reset()
