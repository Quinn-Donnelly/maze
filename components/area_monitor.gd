class_name AreaMonitor
extends Area2D

var areasInside: Dictionary[RID, Node]

func _ready() -> void:
	area_entered.connect(self._on_area_entered)
	area_exited.connect(self._on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	areasInside[area.get_rid()] = area
	
func _on_area_exited(area: Area2D) -> void:
	areasInside.erase(area.get_rid())

func get_areas_inside() -> Array[Node]:
	return areasInside.values()
