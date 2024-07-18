extends AnimatedSprite2D

@export var tile_map: TileMap

@onready var cell_size : Vector2 = tile_map.tile_set.tile_size

var cell_center_position: Vector2

func show_hover_mouse():
	var hover_mouse_position : Vector2 = get_global_mouse_position()
	var tile_map_position : Vector2i = tile_map.local_to_map(hover_mouse_position)
	
# Check if the mouse is hovering over an invalid area
	if tile_map_position.x >= 39 or tile_map_position.y >= 17 or tile_map_position.x < 1 or tile_map_position.y < 1:
		hide()
	else:
		cell_center_position = tile_map.map_to_local(tile_map_position)
		global_position = cell_center_position
		show()

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var click_mouse_position : Vector2 = get_global_mouse_position()
		var tile_map_position : Vector2i = tile_map.local_to_map(click_mouse_position)
		check_tile_data(tile_map_position)
		
		
func check_tile_data(cell_position: Vector2i):
	var tile_data = tile_map.get_cell_tile_data(2, cell_position)
	if tile_data is TileData:
		var buildable = tile_data.get_custom_data_by_layer_id(0)
		if buildable:
			print(buildable)

		
