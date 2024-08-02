extends Deployable
class_name CraftingMaterial

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact") && not DataManager.preview_active:
			consume_resource()
			
func consume_resource() -> void:
	if DataManager.water > 0:
		match resource.material_type:
			"wood":
				DataManager.wood += 1
			"stone":
				DataManager.stone += 1
			"cloth":
				DataManager.cloth += 1
		if DataManager.water > 0:
			DataManager.water -= 1
		queue_free()
