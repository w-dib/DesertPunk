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
@export var tilemap_source : int
@export var tilemap_coordinates : Vector2i
