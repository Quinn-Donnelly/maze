extends Node

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("melee_attack"):
		animationPlayer.play("basic_melee")
