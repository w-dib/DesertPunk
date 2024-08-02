extends Resource
class_name DeployableResource

@export var name: String
@export var sprite: Texture2D
@export var hover_cursor: Texture2D
@export var can_be_free_tile: bool
@export var can_sell := false
@export var costs_action_to_deploy: bool
@export var sprite_scale := Vector2i(1,1)
@export_multiline var descriptor_text: String
@export_enum("animal", "plant", "crafting_material", "building", "free_tile") var resource_type: String
@export_file("*.tscn") var deployable_scene: String

#@export var tile_map_source: int
#@export var tile_map_coordinates: Vector2i

#func action():
		#print("update the action here")
