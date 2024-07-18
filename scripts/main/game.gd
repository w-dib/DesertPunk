extends Node2D

@export var hover_mouse: AnimatedSprite2D
@export var tile_map: TileMap

@export var tile_map_layer: int = 3 #may change for animals vs structures

var preview_active := false
var current_deployable : Deployable
@onready var mouse_position : Vector2
@onready var tile_map_position : Vector2i

func _process(delta: float) -> void:
	
	mouse_position = get_global_mouse_position()
	tile_map_position = tile_map.local_to_map(mouse_position)

	hover_mouse.show_hover_mouse()
	
	if preview_active:
		preview_deployable()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if can_build(tile_map_position):
				print("clicked on buildable spot")
				build()
	else:
		clear_deployable()
	
func _on_ui_deployable_passed(deployable: Deployable) -> void:
	current_deployable = deployable
	preview_active = true

#function to show deployable sprite on mouse position
func preview_deployable():
	if current_deployable:
		tile_map.set_cell(tile_map_layer, tile_map_position, current_deployable.tile_map_source, current_deployable.tile_map_coordinates)
		
		pass

func update_preview_tile():
	pass

#function to queue_free deployable sprite from mouse position
func clear_deployable():
	current_deployable = null
	pass

func can_build(cell_position: Vector2i):
	var tile_data = tile_map.get_cell_tile_data(2, cell_position)
	if tile_data is TileData:
		var buildable = tile_data.get_custom_data_by_layer_id(0)
		if buildable:
			return buildable

func build():
	clear_deployable()
	pass
