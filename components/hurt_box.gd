class_name HurtBox
extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner.set_meta(Constants.HURT_COMPONENT, self)
	area_entered.connect(self._on_hurt_entered)

func _on_hurt_entered(area: Area2D) -> void:
	if area is HitBox:
		if not get_parent().has_meta(Constants.HEALTH_COMPONENT):
			push_warning("Hurt box has not health component")
			return
		var health_component: HealthComponent = get_parent().get_meta(Constants.HEALTH_COMPONENT)
		var current_health = health_component.get_current_health()
		var remaining_health: int = health_component.take_damage(area.get_damage())
		area.dealt_damage(current_health - remaining_health)
