extends Node2D
class_name DeployableComponent

@onready var tile_map: TileMap = get_tree().get_first_node_in_group("tilemap")
@onready var mouse_position : Vector2
@onready var tile_map_position : Vector2i
@onready var building_area := Rect2(0,0,cell_width,cell_height)
@onready var surrounding_cells := []

@export var cell_width: int = 48
@export var cell_height: int = 48
@export var parent_building : Area2D

var has_built = false

signal deployable_deployed

func _input(event):
	if event.is_action_pressed("interact"):
		if can_build(tile_map_position) && DataManager.water != 0:
			deployable_deployed.emit()
			has_built = true
			queue_redraw()

func _process(_delta):
	
	mouse_position = get_global_mouse_position()
	tile_map_position = tile_map.local_to_map(mouse_position)
	
	if !has_built:
		parent_building.global_position = tile_map.map_to_local(tile_map_position)
		building_area.position = -(building_area.size/2)
		queue_redraw()
		
func _draw():
	if can_build(tile_map_position) && !has_built:
		draw_rect(building_area, Color(0,1,0,.5))
	elif !has_built:
		draw_rect(building_area,Color(1,0,0,.5))
	else:
		draw_rect(building_area,Color.TRANSPARENT)

func can_build(cell_position: Vector2i) -> bool:
	# Check tilemap conditions
	for cell in get_all_surrounding_cells(cell_position):
		var tile_data = tile_map.get_cell_tile_data(2, cell)
		if tile_data is TileData:
			var buildable = tile_data.get_custom_data_by_layer_id(0)
			if not buildable:
				return false
		else:
			return false
	# Check for overlapping bodies
	if parent_building.has_overlapping_areas():
		return false
		
	return true
	
func get_all_surrounding_cells(middle_cell):
	surrounding_cells = []
	var target_cell
	for y in range(3):
		for x in range(3):
			target_cell = middle_cell + Vector2i(x - 1, y - 1)
			if target_cell != middle_cell:
				surrounding_cells.append(target_cell)
	return surrounding_cells
