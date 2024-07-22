extends Area2D

@export var descriptor_text: Label
@export var descriptor_ui: Control
@export var resource: DeployableResource
@export var custom_cursor: Texture2D
@export var default_cursor: Texture2D

var has_built = false
var first_click = true

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
			pass #add code to sell if animal ate food here.
