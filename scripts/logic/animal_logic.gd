extends Deployable
class_name Animal

var first_click := true

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact") && not DataManager.preview_active:
		SoundManager.play_random_sound()
		if ready_for_sale:
			sell()
		elif first_click:
			first_click = false
		else:
			print("add animal action!")

func sell() -> void:
	SoundManager.play_sound(4)
	DataManager.coins += resource.sells_for
	Input.set_custom_mouse_cursor(default_cursor)
	queue_free()
