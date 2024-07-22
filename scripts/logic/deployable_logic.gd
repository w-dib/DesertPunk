extends Area2D

@export var descriptor_text: Label
@export var descriptor_ui: Control
@export var resource: DeployableResource
@export var custom_cursor: Texture2D
@export var default_cursor: Texture2D

var has_built = false
var first_click = true
var current_sprite_index : int = 1

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

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact") && has_built:
		if first_click:
			first_click = false
		else:
			advance_sprite()

func advance_sprite():
	if current_sprite_index < resource.growth_time && DataManager.water > 0:
		hide_sprite(current_sprite_index)
		current_sprite_index += 1
		show_sprite(current_sprite_index)
		if DataManager.water > 0:
			DataManager.water -= 1
		
func hide_sprite(index):
	var node = find_child(str(index))
	node.hide()

func show_sprite(index):
	var node = find_child(str(index))
	node.show()
