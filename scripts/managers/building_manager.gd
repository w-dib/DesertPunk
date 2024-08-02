extends ShapeCast2D

signal buildable_state_changed(can_build: bool)

var resource_type := ""

func _process(delta: float) -> void:
	if is_colliding():
				var can_build = true
				match resource_type:
					"animal":
						can_build = check_animal_build_conditions()
					"plant":
						can_build = check_plant_build_conditions()
					"crafting_material":
						can_build = check_crafting_material_build_conditions()
					"building":
						can_build = check_building_build_conditions()
					"free_tile":
						can_build = check_free_tile_build_conditions()
					_:
						can_build = false
				buildable_state_changed.emit(can_build)
				return
		#buildable_state_changed.emit(false)
	else:
		buildable_state_changed.emit(false)

func check_animal_build_conditions() -> bool:
	var has_foundation = false
	var has_farm = false
	var has_animal = false

	var collision_count = get_collision_count()
	for i in range(collision_count):
		var collider = get_collider(i)
		if collider:
			var groups = collider.get_groups()
			if "tilemap" in groups:
				has_foundation = true
			if "farm" in groups:
				has_farm = true
				collider.has_animal = true ### this should be in the deployment_manager script
			if "animal" in groups:
				has_animal = true
			
			# Check if collider is in any other group
			for group in groups:
				if group not in ["tilemap", "building", "farm"]:
					return false

	# Check conditions based on the presence of foundation, farm, and animal
	if has_foundation and has_farm and not has_animal:
		return true
	elif has_foundation and not has_farm:
		return false
	elif has_foundation and has_farm and has_animal:
		return false

	return false
	
func check_plant_build_conditions() -> bool:
	var collision_count = get_collision_count()
	for i in collision_count:
		var collider: Object = get_collider(i)
		if collider:
			if not collider.is_in_group("tilemap"):
				return false
	return true

func check_crafting_material_build_conditions():
	var collision_count = get_collision_count()
	for i in collision_count:
		var collider = get_collider(i)
		if collider:
			if not collider.is_in_group("tilemap"):
				return false
	return true
	
func check_building_build_conditions():
	var collision_count = get_collision_count()
	for i in collision_count:
		var collider = get_collider(i)
		if collider:
			if not collider.is_in_group("tilemap"):
				return false
	return true
	
func check_free_tile_build_conditions():
	var collision_count = get_collision_count()
	for i in collision_count:
		var collider = get_collider(i)
		if collider:
			if not collider.is_in_group("tilemap"):
				return false
	return true
	
