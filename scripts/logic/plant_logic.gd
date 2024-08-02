extends Deployable
class_name Plant

var first_click := true
var current_sprite_index := 1

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact") && not DataManager.preview_active:
		if first_click:
			first_click = false
		else:
			advance_sprite()

func advance_sprite() -> void:
	if current_sprite_index < resource.growth_time && DataManager.water > 0:
		hide_sprite(current_sprite_index)
		current_sprite_index += 1
		show_sprite(current_sprite_index)
		if DataManager.water > 0:
			DataManager.water -= 1
		
func hide_sprite(index: int) -> void:
	var node = find_child(str(index))
	node.hide()

func show_sprite(index: int) -> void:
	var node = find_child(str(index))
	node.show()
