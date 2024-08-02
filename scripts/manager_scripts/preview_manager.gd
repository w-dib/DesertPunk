extends Node2D
class_name PreviewManager

var preview_active := false
var can_build := false
var can_afford := false
var current_deployable_resource: DeployableResource
#signal deployable_deployed #add to interaction_manager script

@export var cell_width: int = 46
@export var cell_height: int = 46

@onready var building_area := Rect2(0,0,cell_width,cell_height)
@onready var surrounding_cells := []
@onready var mouse_position: Vector2
@onready var tile_map_position: Vector2i
@onready var tile_map: TileMap = %TileMap
@onready var buildable_manager: ShapeCast2D = %BuildableManager
@onready var preview_sprite: Sprite2D = $PreviewSprite
@onready var deployment_manager: Node2D = $DeploymentManager
@onready var tiles: Node = %Tiles

func _ready() -> void:
	buildable_manager.buildable_state_changed.connect(_on_buildable_state_changed)

func _process(_delta: float) -> void:
	mouse_position = get_global_mouse_position()
	tile_map_position = tile_map.local_to_map(mouse_position)
	global_position = tile_map.map_to_local(tile_map_position)
	building_area.position = -(building_area.size/2)
	#if preview_active:
	queue_redraw()
		
func preview(deployable: DeployableResource):
	if not preview_active:
		preview_active = true
	current_deployable_resource = deployable
	buildable_manager.show()
	buildable_manager.enabled = true
	buildable_manager.resource_type = deployable.resource_type
	preview_sprite.scale = deployable.sprite_scale
	preview_sprite.texture = deployable.sprite

func check_if_can_afford(current_deployable) -> bool:
	return deployment_manager.check(current_deployable)

func build() -> void:
	var scene = load(current_deployable_resource.deployable_scene).instantiate()
	tiles.add_child(scene)
	if current_deployable_resource.resource_type == "building": 
		DataManager.wood -= current_deployable_resource.cost_wood
		DataManager.stone -= current_deployable_resource.cost_stone
		DataManager.cloth -= current_deployable_resource.cost_cloth
	scene.global_position = global_position
	if DataManager.water > 0:
		DataManager.water -= 1
	cancel_preview()

func cancel_preview():
	preview_sprite.texture = null
	buildable_manager.hide()
	buildable_manager.enabled = false
	buildable_manager.resource_type = ""
	preview_active = false
	queue_redraw()
			
func _draw():
	if preview_active:
		if can_build:
			draw_rect(building_area, Color(0, 1, 0, 0.5)) # Green
		else:
			draw_rect(building_area, Color(1, 0, 0, 0.5)) # Red
	else:
		#draw_rect(building_area,Color.TRANSPARENT)
		draw_rect(building_area, Color(0.980392, 0.921569, 0.843137, 0.3), 1.0)

func _input(event) -> void:		
	if event.is_action_pressed("cancel") and preview_active:
		cancel_preview()
	if event.is_action_pressed("interact") && can_build:
		if check_if_can_afford(current_deployable_resource):
			build()

func _on_buildable_state_changed(check_can_build: bool) -> void:
	can_build = check_can_build
