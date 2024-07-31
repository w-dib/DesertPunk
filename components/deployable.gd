extends Area2D
class_name Deployable

@export var resource: DeployableResource

var has_built: bool = false

@onready var descriptor_ui: Control = %DescriptorUI
@onready var descriptor_text: Label = %DescriptorText
@onready var default_cursor: Texture = preload("res://assets/icons/pointer_toon_a.svg")

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	descriptor_text.text = resource.descriptor_text
	descriptor_ui.hide()

func _on_mouse_entered() -> void:
	if has_built:
		descriptor_ui.show()
		if resource.hover_cursor:
			Input.set_custom_mouse_cursor(resource.hover_cursor)

func _on_mouse_exited() -> void:
	if has_built:
		descriptor_ui.hide()
		if default_cursor:
			Input.set_custom_mouse_cursor(default_cursor)
