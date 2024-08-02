extends Building

var has_animal := false

func _on_mouse_entered() -> void:
	if not has_animal && not DataManager.preview_active:
		descriptor_ui.show()
		if resource.hover_cursor:
			Input.set_custom_mouse_cursor(resource.hover_cursor)
