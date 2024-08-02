extends Deployable
class_name Plant

var first_click := true
var current_sprite_index := 1
var is_plant_watered := false

@onready var floor_wet: Sprite2D = $FloorWet

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact") && not DataManager.preview_active:
		if first_click:
			first_click = false
		else:
			update_floor()

func advance_sprite() -> void:
	if current_sprite_index < resource.growth_time && DataManager.water > 0:
		floor_wet.hide()
		hide_sprite(current_sprite_index)
		current_sprite_index += 1
		show_sprite(current_sprite_index)

		
func hide_sprite(index: int) -> void:
	var node = find_child(str(index))
	node.hide()

func show_sprite(index: int) -> void:
	var node = find_child(str(index))
	node.show()

func update_floor() -> void:
	if not is_plant_watered:
		if DataManager.water > 0:
			DataManager.water -= 1
			is_plant_watered = true
	if is_plant_watered:
		floor_wet.show()
	else:
		return
