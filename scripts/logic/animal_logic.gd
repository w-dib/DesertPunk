extends Deployable
class_name Animal

var first_click := true

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact") && not DataManager.preview_active:
		if ready_for_sale:
			sell()
		elif first_click:
			first_click = false
		else:
			print("add animal action!")

func sell() -> void:
		DataManager.coins += resource.sells_for
		Input.set_custom_mouse_cursor(default_cursor)
		queue_free()
