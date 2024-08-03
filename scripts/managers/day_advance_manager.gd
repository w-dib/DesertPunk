extends Node

@export var tiles : Node2D

func advance_day() -> void:
	DataManager.water = 10
	var children: Array[Node] = tiles.get_children()
	for child: Node in children:
		if child.has_method("advance_day"):
			child.advance_day()
