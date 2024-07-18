extends Resource
class_name Deployable

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
