extends Deployable
class_name Building

var first_click := true

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact") && not DataManager.preview_active:
		SoundManager.play_random_sound()
		if first_click:
			first_click = false
		else:
			print("add building action!")
