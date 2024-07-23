extends Area2D

@export var descriptor_text: Label
@export var descriptor_ui: Control
@export var resource: Building
@export var custom_cursor: Texture2D
@export var default_cursor: Texture2D

var has_built = false
var first_click = true
var overlaps_with_animal = false

func _ready() -> void:
	descriptor_text.text = resource.descriptor_text
	descriptor_ui.hide()
	
func _on_mouse_entered() -> void:
	if has_built:
		descriptor_ui.show()
		if custom_cursor:
			Input.set_custom_mouse_cursor(custom_cursor)

func _on_mouse_exited() -> void:
	if has_built:
		descriptor_ui.hide()
		if default_cursor:
			Input.set_custom_mouse_cursor(default_cursor)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("interact") && has_built && !overlaps_with_animal:
		if first_click:
			first_click = false
		else:
			resource.action()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("animal") && !area.has_built:
		overlaps_with_animal = true


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("animal") && !area.has_built:
		overlaps_with_animal = false
