class_name HitBox
extends Area2D

@export var damage: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner.set_meta(Constants.HIT_COMPONENT, self)
	area_entered.connect(self._on_hit)
	
func _on_hit(area: Area2D) -> void:
	if area is HurtBox and area.owner != owner:
		print("we've struck, damage not yet confirmed")

func dealt_damage(damage_dealt: int) -> void:
	print("confirmed we dealth %d damage" % damage_dealt)

func get_damage() -> int:
	return damage
