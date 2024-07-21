extends Area2D

@export var descriptor_text: Label
@export var descriptor_ui: Control

@export var resource: DeployableResource

var has_built = false

func _ready() -> void:
	descriptor_text.text = resource.descriptor_text
	descriptor_ui.hide()
	
func _on_mouse_entered() -> void:
	if has_built:
		descriptor_ui.show()

func _on_mouse_exited() -> void:
	if has_built:
		descriptor_ui.hide()
