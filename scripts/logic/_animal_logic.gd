extends Area2D

@export var descriptor_text: Label
@export var descriptor_ui: Control
@export var resource: DeployableResource
@export var custom_cursor: Texture2D
@export var default_cursor: Texture2D

@onready var deployable_component: DeployableComponent = $DeployableComponent

var has_built = false
var first_click = true
var animal_deployed = false

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
	if event.is_action_pressed("interact") and has_built:
		if first_click:
			first_click = false
		else:
			resource.action()

func update_deploying_in_farm() -> void:
	var overlapping_areas = get_overlapping_areas()
	for overlap in overlapping_areas:
		if overlap.is_in_group("animal") and overlap.animal_deployed:
			deployable_component.deploying_in_farm = false
			return
	deployable_component.deploying_in_farm = true

func _on_area_entered(area: Area2D) -> void:
	if not has_built:
		update_deploying_in_farm()

func _on_area_exited(area: Area2D) -> void:
	if not has_built:
		update_deploying_in_farm()
