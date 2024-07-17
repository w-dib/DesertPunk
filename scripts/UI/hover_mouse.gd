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
