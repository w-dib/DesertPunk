extends Node2D

func check(current_deployable: DeployableResource) -> bool:
	if DataManager.water <= 0:
		return false
	if current_deployable.resource_type == "building":
		return DataManager.wood >= current_deployable.cost_wood && DataManager.stone >= current_deployable.cost_stone && DataManager.cloth >= current_deployable.cost_cloth
	return true
	
