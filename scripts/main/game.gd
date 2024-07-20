extends Node2D

@onready var tiles: Node = $Tiles

@onready var mouse_position : Vector2
@onready var tile_map_position : Vector2i

@export var hover_mouse: AnimatedSprite2D
@export var tile_map: TileMap

var current_deployable : DeployableResource = null
var preview_active := false
var deployable_component : Node2D
var preview_scene : Node2D

func _process(_delta: float) -> void:
	mouse_position = get_global_mouse_position()
	tile_map_position = tile_map.local_to_map(mouse_position)
	if !preview_active:
		hover_mouse.show_hover_mouse()

func _input(event):
	if event.is_action_pressed("cancel"):
		if preview_active:
			preview_active = false
			get_tree().get_first_node_in_group("preview_tile").queue_free()

func _on_ui_deployable_passed(deployable: DeployableResource) -> void:
	if !preview_active:
		preview_active = true
		current_deployable = deployable
		preview_scene = load(current_deployable.deployable_scene).instantiate()
		tiles.add_child(preview_scene)
		preview_scene.add_to_group("preview_tile")
		deployable_component = preview_scene.get_node("DeployableComponent")
		deployable_component.deployable_deployed.connect(_on_deployable_deployed)

func _on_deployable_deployed() -> void:
	preview_scene.remove_from_group("preview_tile")
	preview_scene.add_to_group("deployed_tiles")
	preview_active = false
	current_deployable = null
