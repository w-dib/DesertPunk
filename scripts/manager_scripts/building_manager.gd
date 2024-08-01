extends ShapeCast2D

func _process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider(0)
		if collider:
			if collider is Plant:
				print("Colliding with a plant")
			else:
				print("Colliding with an instance of ", collider.get_class())
		else:
			print("No collider found")
	else:
		print("Not colliding")
