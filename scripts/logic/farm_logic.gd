extends Building

var has_animal := false

func _on_mouse_entered() -> void:
	if has_built and not has_animal:
		descriptor_ui.show()
		if resource.hover_cursor:
			Input.set_custom_mouse_cursor(resource.hover_cursor)
