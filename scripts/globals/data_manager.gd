extends Node

signal ui_data_updated(variable_name: String, new_value: int)

var calendar: int = 1:
	set(new_value):
		if calendar != new_value:
			calendar = new_value
			ui_data_updated.emit("calendar", new_value)
var coins: int = 10:
	set(new_value):
		if coins != new_value:
			coins = new_value
			ui_data_updated.emit("coins", new_value)
var water: int = 10:
	set(new_value):
		if water != new_value:
			water = new_value
			ui_data_updated.emit("water", new_value)
var wood: int = 10:
	set(new_value):
		if wood != new_value:
			wood = new_value
			ui_data_updated.emit("wood", new_value)
var stone: int = 1:
	set(new_value):
		if stone != new_value:
			stone = new_value
			ui_data_updated.emit("stone", new_value)
var cloth: int = 1:
	set(new_value):
		if cloth != new_value:
			cloth = new_value
			ui_data_updated.emit("cloth", new_value)

#NOTE preview_manager global below:
var preview_active := false
