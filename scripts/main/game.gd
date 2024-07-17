extends Node2D

@onready var hover_mouse: AnimatedSprite2D = $HoverMouse

func _process(delta: float) -> void:
	hover_mouse.show_hover_mouse()
