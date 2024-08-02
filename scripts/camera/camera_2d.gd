extends Camera2D

@export var zoom_increment := 0.05
@export var zoom_min := 1
@export var zoom_max := 1.5
@export var viewport_width := 640
@export var viewport_height := 360
@export var lerp_speed := 10.0

var panning := false
var zoom_level := 1.0

@onready var initial_position := global_position

func _process(delta: float) -> void:
	if zoom_level == 1.0 and global_position != initial_position:
		global_position = global_position.lerp(initial_position, lerp_speed * delta)

func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton:
		match _event.button_index:
			MOUSE_BUTTON_LEFT:
				if Input.is_key_pressed(KEY_CTRL):
					if _event.pressed:
						panning = true
					else:
						panning = false
					get_tree().get_root().set_input_as_handled()
			MOUSE_BUTTON_WHEEL_UP:
				zoom_level = clamp(zoom_level + zoom_increment, zoom_min, zoom_max)
				zoom = zoom_level * Vector2.ONE
				get_tree().get_root().set_input_as_handled()
			MOUSE_BUTTON_WHEEL_DOWN:
				zoom_level = clamp(zoom_level - zoom_increment, zoom_min, zoom_max)
				zoom = zoom_level * Vector2.ONE
				get_tree().get_root().set_input_as_handled()
	elif _event is InputEventMouseMotion and panning:
		get_tree().get_root().set_input_as_handled()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_key_pressed(KEY_CTRL):
			var new_position : Vector2 = global_position - _event.relative / zoom_level
			global_position = clamp_to_viewport(new_position)
		else:
			panning = false

func clamp_to_viewport(new_position: Vector2) -> Vector2:
	var viewport_size = Vector2(viewport_width, viewport_height) / zoom_level
	var margin = viewport_size * 0.1

	var min_x : float = margin.x
	var max_x : float = viewport_width - margin.x
	var min_y : float = margin.y
	var max_y : float = viewport_height - margin.y

	return Vector2(
		clamp(new_position.x, min_x, max_x),
		clamp(new_position.y, min_y, max_y)
	)
