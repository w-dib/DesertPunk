extends Resource
class_name DeployableResource

@export var name: String
@export var sprite: Texture2D
@export var hover_cursor: Texture2D
@export var can_be_free_tile : bool
@export var costs_action_to_deploy : bool
@export_multiline var descriptor_text: String
@export_file("*.tscn") var deployable_scene: String

#@export var tile_map_source : int
#@export var tile_map_coordinates : Vector2i

#func action():
		#print("update the action here")