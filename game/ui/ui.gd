class_name UI
extends CanvasLayer

@onready var gameWinLabel: Label = $GameWinLabel
@onready var playAgainButton: Button = $PlayAgainButton
@onready var gameLoseLabel: Label = $GameLoseLabel
@onready var playerHealthContainer: Container = $PlayerHealth

@export_category("Player Health")
@export var health_indicator: Texture
@export var health_depleted: Texture
var healthIndicators: Array[TextureRect] = []
var currentHealthIdx: int

func _ready() -> void:
	_reset()
	EventBus.player_win_zone.connect(self._on_player_win_zone)
	EventBus.player_died.connect(self._on_player_died)
	playAgainButton.pressed.connect(self._on_play_again)
	EventBus.player_damaged.connect(self._on_player_damaged)

func _reset() -> void:
	gameWinLabel.hide()
	gameLoseLabel.hide()
	playAgainButton.hide()
	_clean_up_player_health()
	_create_player_health(3)

func _on_player_win_zone() -> void:
	gameWinLabel.show()
	playAgainButton.show()

func _on_player_died() -> void:
	gameLoseLabel.show()
	playAgainButton.show()

func _on_play_again() -> void:
	EventBus.play_again.emit()
	_reset()
	
func _create_player_health(healthValue: int) -> void:
	for num in range(healthValue):
		var sprite = TextureRect.new()
		sprite.texture = health_indicator
		healthIndicators.push_back(sprite)
		playerHealthContainer.add_child(sprite)
	currentHealthIdx = healthValue - 1

func _clean_up_player_health() -> void:
	healthIndicators.clear()
	currentHealthIdx = -1
	for child in playerHealthContainer.get_children():
		child.queue_free()

func _take_health() -> void:
	if currentHealthIdx < 0:
		return
	healthIndicators[currentHealthIdx].texture = health_depleted
	currentHealthIdx -= 1

func _on_player_damaged(damage: int) -> void:
	for d in range(damage):
		_take_health()
