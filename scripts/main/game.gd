extends Node2D

@onready var tiles: Node = $Tiles
@onready var ui: CanvasLayer = $UI

@export var hover_mouse: AnimatedSprite2D
@export var tile_map: TileMap

var current_deployable : DeployableResource = null
var preview_active := false
var deployable_component : Node2D
var preview_scene : Node2D

func _ready() -> void:
	ui.deployable_passed.connect(_on_ui_deployable_passed)
	ui.day_advanced.connect(_on_day_advanced)
	pass

#func _process(_delta: float) -> void:
	#if !preview_active:
		#hover_mouse.show_hover_mouse()

func _input(event):
	if event.is_action_pressed("cancel"):
		if preview_active:
			preview_active = false
			get_tree().get_first_node_in_group("preview_tile").queue_free()

func _on_ui_deployable_passed(deployable: DeployableResource) -> void:
	if preview_active:
		var current_preview = get_tree().get_first_node_in_group("preview_tile")
		if current_preview:
			current_preview.queue_free()
		build(deployable)
	else:
		build(deployable)

func _on_deployable_deployed() -> void:
	preview_scene.remove_from_group("preview_tile")
	preview_scene.add_to_group("deployed_tiles")	
	preview_active = false
	current_deployable = null
	DataManager.water -= 1
	for node in get_tree().get_nodes_in_group("deployed_tiles"):
		var deployable_component = node.get_node("DeployableComponent")
		if deployable_component.has_signal("deployable_deployed"):
			if deployable_component.is_connected("deployable_deployed" , _on_deployable_deployed):
				deployable_component.disconnect("deployable_deployed" , _on_deployable_deployed)

func build(deployable):
	preview_active = true
	current_deployable = deployable
	preview_scene = load(current_deployable.deployable_scene).instantiate()
	tiles.add_child(preview_scene)
	preview_scene.add_to_group("preview_tile")
	deployable_component = preview_scene.get_node("DeployableComponent")
	deployable_component.deployable_deployed.connect(_on_deployable_deployed)

func _on_day_advanced():
	DataManager.water = 10
	
