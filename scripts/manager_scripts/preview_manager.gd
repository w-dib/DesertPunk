extends Sprite2D
class_name PreviewManager

var preview_active := false
var can_build := false
#signal deployable_deployed #add to interaction_manager script

@export var cell_width: int = 16
@export var cell_height: int = 16

@onready var building_area := Rect2(0,0,cell_width,cell_height)
@onready var surrounding_cells := []
@onready var mouse_position : Vector2
@onready var tile_map_position : Vector2i
@onready var tile_map: TileMap = %TileMap

func _process(_delta: float) -> void:
	if preview_active:
		mouse_position = get_global_mouse_position()
		tile_map_position = tile_map.local_to_map(mouse_position)
		global_position = tile_map.map_to_local(tile_map_position)
		building_area.position = -(building_area.size/2)
		queue_redraw()
		
func preview(sprite):
	if not preview_active:
		preview_active = true
	texture = sprite
	
func _draw():
	if preview_active:
		draw_rect(building_area, Color(0,1,0,.5))
	else:
		return

func _input(event) -> void:
	if event.is_action_pressed("cancel"):
		if preview_active:
			texture = null
			preview_active = false
