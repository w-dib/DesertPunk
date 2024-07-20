extends Resource
class_name DeployableResource

enum TileType {
	GROWABLE,
	BUILDING,
	CONSTRUCTION,
	FREE_TILE
}

@export var can_be_free_tile : bool
@export var costs_action_to_deply : bool
@export var tile_map_source : int
@export var tile_map_coordinates : Vector2i
@export_file("*.tscn") var deployable_scene: String
