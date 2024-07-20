extends Node2D

#@export var hover_mouse: AnimatedSprite2D
#@export var tile_map: TileMap
#
#@onready var mouse_position : Vector2
#@onready var tile_map_position : Vector2i
@onready var deployed_tiles: Node = $DeployedTiles
@onready var preview_tile: Node = $PreviewTile

var current_deployable : DeployableResource
var preview_active := false
#func _process(_delta: float) -> void:
	#mouse_position = get_global_mouse_position()
	#tile_map_position = tile_map.local_to_map(mouse_position)
#
	#hover_mouse.show_hover_mouse()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_RIGHT:
		if preview_active:
			preview_tile.get_child(0).queue_free()
			preview_active = false

func _on_ui_deployable_passed(deployable: DeployableResource) -> void:
	print("pressed")
	if !preview_active:
		preview_active = true
		current_deployable = deployable
		var preview_scene = load(current_deployable.deployable_scene).instantiate()
		preview_tile.add_child(preview_scene)
		var deployable_component = preview_scene.get_node("DeployableComponent")
	else:
		current_deployable = null
