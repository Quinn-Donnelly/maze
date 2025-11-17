class_name UI
extends CanvasLayer

@onready var gameWinLabel: Label = $GameWinLabel
@onready var playAgainButton: Button = $PlayAgainButton
@onready var gameLoseLabel: Label = $GameLoseLabel

func _ready() -> void:
	_reset()
	EventBus.player_win_zone.connect(self._on_player_win_zone)
	EventBus.player_died.connect(self._on_player_died)
	playAgainButton.pressed.connect(self._on_play_again)

func _reset() -> void:
	gameWinLabel.hide()
	gameLoseLabel.hide()
	playAgainButton.hide()

func _on_player_win_zone() -> void:
	gameWinLabel.show()
	playAgainButton.show()

func _on_player_died() -> void:
	gameLoseLabel.show()
	playAgainButton.show()

func _on_play_again() -> void:
	EventBus.play_again.emit()
	_reset()
