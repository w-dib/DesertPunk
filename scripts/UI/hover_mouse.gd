extends AnimatedSprite2D

@export var tile_map: TileMap

@onready var cell_size : Vector2 = tile_map.tile_set.tile_size

var cell_center_position: Vector2

func show_hover_mouse():
	var hover_mouse_position : Vector2 = get_global_mouse_position()
	var tile_map_position : Vector2i = tile_map.local_to_map(hover_mouse_position)
	
# Check if the mouse is hovering over an invalid area
	if tile_map_position.x > 36 or tile_map_position.y > 15 or tile_map_position.x < 3 or tile_map_position.y < 3:
		hide()
	else:
		cell_center_position = tile_map.map_to_local(tile_map_position)
		global_position = cell_center_position
		show()
