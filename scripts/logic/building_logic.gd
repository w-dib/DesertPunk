extends Area2D

@export var descriptor_text: Label
@export var descriptor_ui: Control
@export var resource: DeployableResource

var has_built = false
var first_click = true

func _ready() -> void:
	descriptor_text.text = resource.descriptor_text
	descriptor_ui.hide()
	
func _on_mouse_entered() -> void:
	if has_built:
		descriptor_ui.show()

func _on_mouse_exited() -> void:
	if has_built:
		descriptor_ui.hide()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("interact") && has_built:
		if first_click:
			first_click = false
		else:
			resource.action()
