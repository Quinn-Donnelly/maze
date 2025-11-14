class_name AreaMonitor
extends Area2D

signal area_occupied
signal area_empty
var nodesInside: Dictionary[RID, Node2D]

func _ready() -> void:
	area_entered.connect(self._on_area_entered)
	area_exited.connect(self._on_area_exited)
	body_entered.connect(self._on_body_entered)
	body_exited.connect(self._on_body_exited)

func _on_area_entered(area: Area2D) -> void:
	_add_node(area)

func _on_area_exited(area: Area2D) -> void:
	_remove_node(area)

func get_areas_inside() -> Array[Node2D]:
	return nodesInside.values()

func _on_body_entered(body: Node2D) -> void:
	_add_node(body)

func _on_body_exited(body: Node2D) -> void:
	_remove_node(body)
	
func _add_node(node: Node2D) -> void:
	nodesInside[node.get_rid()] = node
	if nodesInside.size() == 1:
		area_occupied.emit()

func _remove_node(node: Node2D) -> void:
	nodesInside.erase(node.get_rid())
	if nodesInside.size() == 0:
		area_empty.emit()
