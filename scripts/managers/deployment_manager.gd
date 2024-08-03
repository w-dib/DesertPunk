extends Node2D

signal out_of_resource(resource: String)

func check(current_deployable: DeployableResource) -> bool:
	var missing_resources = []

	if DataManager.water <= 0:
		SoundManager.play_sound(6)
		missing_resources.append("water")

	if current_deployable.resource_type == "building":
		if DataManager.wood < current_deployable.cost_wood:
			missing_resources.append("wood")
		if DataManager.stone < current_deployable.cost_stone:
			missing_resources.append("stone")
		if DataManager.cloth < current_deployable.cost_cloth:
			missing_resources.append("cloth")

	if missing_resources.size() > 0:
		SoundManager.play_sound(6)
		for resource in missing_resources:
			out_of_resource.emit(resource)
		return false

	return true
