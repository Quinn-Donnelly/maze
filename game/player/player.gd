class_name Player
extends CharacterBody2D

@export var speed: float = 350
@onready var healthComponent: HealthComponent = $HealthComponent

func _ready() -> void:
	EventBus.play_again.connect(self._on_play_again)
	healthComponent.health_depleted.connect(self._on_health_depleted)

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

func _on_play_again() -> void:
	set_process(true)
	set_physics_process(true)
	healthComponent.reset()

func _on_health_depleted() -> void:
	set_process(false)
	set_physics_process(false)
	EventBus.player_died.emit()
