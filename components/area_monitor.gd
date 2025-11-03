class_name AreaMonitor
extends Area2D

signal area_occupied
signal area_empty
var areasInside: Dictionary[RID, Area2D]

func _ready() -> void:
	area_entered.connect(self._on_area_entered)
	area_exited.connect(self._on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	areasInside[area.get_rid()] = area
	if areasInside.size() == 1:
		area_occupied.emit()
	
func _on_area_exited(area: Area2D) -> void:
	areasInside.erase(area.get_rid())
	if areasInside.size() == 0:
		area_empty.emit()

func get_areas_inside() -> Array[Area2D]:
	return areasInside.values()
