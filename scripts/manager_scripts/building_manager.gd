extends ShapeCast2D

signal buildable_state_changed(can_build: bool)

var resource_type := ""
var collision_count := 0

func _process(delta: float) -> void:
	if is_colliding():
				var can_build = true
				match resource_type:
					#"animal":
						#can_build = check_animal_build_conditions(collider)
					"plant":
						can_build = check_plant_build_conditions()
					#"material":
						#can_build = check_material_build_conditions(collider)
					#"building":
						#can_build = check_building_build_conditions(collider)
					#"free_tile":
						#can_build = check_free_tile_build_conditions(collider)
					_:
						can_build = false
				buildable_state_changed.emit(can_build)
				return
		#buildable_state_changed.emit(false)
	else:
		buildable_state_changed.emit(false)

func check_animal_build_conditions(collider):
	pass
	
func check_plant_build_conditions() -> bool:
	var collision_count = get_collision_count()
	for i in collision_count:
		var collider = get_collider(i)
		if collider:
			if not collider.is_in_group("tilemap"):
				return false
	return true
	
	#if collider.is_in_group("tilemap"):
		#return true
		#print(collider)
	#else:
		#return false

func check_material_build_conditions(collider):
	pass
	
func check_building_build_conditions(collider):
	pass
	
func check_free_tile_build_conditions(collider):
	pass
	
