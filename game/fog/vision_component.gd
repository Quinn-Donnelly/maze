class_name VisionComponent
extends Node

## The sprite will represent radius of site as well as how clear - full white full vision
@export var sprite: Sprite2D

func _ready() -> void:
	get_parent().set_meta(Constants.VISION_COMPONENT, self)

func getVisionSprite() -> Sprite2D:
	return sprite

func _exit_tree() -> void:
	get_parent().remove_meta(Constants.VISION_COMPONENT)
