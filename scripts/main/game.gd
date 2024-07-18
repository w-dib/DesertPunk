extends Node2D

@export var hover_mouse: AnimatedSprite2D
@export var tile_map: TileMap

func _process(delta: float) -> void:
	hover_mouse.show_hover_mouse()
	
	##code for checking if buildable or not##
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#var click_mouse_position : Vector2 = get_global_mouse_position()
		#var tile_map_position : Vector2i = tile_map.local_to_map(click_mouse_position)
		#print(tile_map_position)
		#can_build(tile_map_position)
		#
#func can_build(cell_position: Vector2i):
	#var tile_data = tile_map.get_cell_tile_data(2, cell_position)
	#if tile_data is TileData:
		#var buildable = tile_data.get_custom_data_by_layer_id(0)
		#if buildable:
			#return buildable


