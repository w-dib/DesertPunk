extends Node

@export var tiles : Node2D

func advance_day() -> void:
	DataManager.water = 10
	var children = tiles.get_children()
	for child in children:
		if child.has_method("advance_day"):
			child.advance_day()
