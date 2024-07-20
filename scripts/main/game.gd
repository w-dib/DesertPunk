extends Node2D

@export var hover_mouse: AnimatedSprite2D
@export var tile_map: TileMap


var current_deployable : DeployableResource
@onready var mouse_position : Vector2
@onready var tile_map_position : Vector2i
@onready var deployed_tiles: Node = $DeployedTiles

func _process(_delta: float) -> void:
	mouse_position = get_global_mouse_position()
	tile_map_position = tile_map.local_to_map(mouse_position)

	#hover_mouse.show_hover_mouse()
	
func _on_ui_deployable_passed(deployable: DeployableResource) -> void:
	current_deployable = deployable
	var loaded_deployable = load(current_deployable.deployable_scene)
	var deployable_scene = loaded_deployable.instantiate()
	deployed_tiles.add_child(deployable_scene)
