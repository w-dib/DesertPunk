extends CanvasLayer

signal deployable_passed(deployable: DeployableResource)
signal day_advanced

@export var build_bar: PanelContainer

#tile buttons
@export var barley_button: Button
@export var dates_button: Button
@export var goat_button: Button
@export var camel_button: Button
@export var farm_button: Button

#other buttons
@export var end_day_button: Button
@export var hammer_button: Button
@export var popup_panel: Control
@export var yes_button: Button
@export var no_button: Button

#resources
@export var barley_resource: PlantResource 
@export var dates_resource: PlantResource
@export var goat_resource: PlantResource
@export var camel_resource: AnimalResource
@export var farm_resource: BuildingResource

#texts
@onready var calendar_text: Label = %CalendarText
@onready var coin_text: Label = %CoinText
@onready var wood_text: Label = %WoodText
@onready var stone_text: Label = %StoneText
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var water_text: Label = %WaterText

func _ready() -> void:
	popup_panel.hide()
	connect_signals()
	update_ui_data_text()
	
func handle_action_bar_press(button_pressed: Button) -> void:
	match button_pressed:
		barley_button:
			deploy(barley_resource)
		dates_button:
			deploy(dates_resource)
		goat_button:
			deploy(goat_resource)
		camel_button:
			print("camel")
		farm_button:
			deploy(farm_resource)
		end_day_button:
			check_end_day()
		yes_button:
			emit_signal("day_advanced")
			DataManager.calendar += 1
			popup_panel.hide()
		no_button:
			popup_panel.hide()

func _on_hammer_button_toggled(_toggled_on: bool) -> void:
	build_bar.visible = !build_bar.visible

func deploy(resource: DeployableResource) -> void:
	deployable_passed.emit(resource)

func check_end_day() -> void:
	popup_panel.show()

func on_ui_data_updated(variable_name: String, new_value: int) -> void:
	update_ui_data_text()
	match variable_name:
		"calendar":
			tween_label(calendar_text)
		"coins":
			tween_label(coin_text)
		"water":
			tween_label(water_text)
		"wood":
			tween_label(wood_text)
		"stone":
			tween_label(stone_text)
		#"cloth":
			#tween_label(cloth_text)

func tween_label(label: Label) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(label, "scale", Vector2(1.5, 1.5), 0.2).set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property(label, "modulate", Color.GREEN, 0.2)
	tween.tween_property(label, "scale", Vector2(1, 1), 0.2).set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property(label, "modulate", Color.WHITE, 0.2)

func update_ui_data_text() -> void:
	calendar_text.text = str(DataManager.calendar)
	coin_text.text = str(DataManager.coins)
	wood_text.text = str(DataManager.wood)
	stone_text.text = str(DataManager.stone)
	water_text.text = str(DataManager.water) + " / 10"
	progress_bar.value = DataManager.water

func connect_signals() -> void:
	barley_button.pressed.connect(handle_action_bar_press.bind(barley_button))
	dates_button.pressed.connect(handle_action_bar_press.bind(dates_button))
	goat_button.pressed.connect(handle_action_bar_press.bind(goat_button))
	camel_button.pressed.connect(handle_action_bar_press.bind(camel_button))
	farm_button.pressed.connect(handle_action_bar_press.bind(farm_button))
	end_day_button.pressed.connect(handle_action_bar_press.bind(end_day_button))
	yes_button.pressed.connect(handle_action_bar_press.bind(yes_button))
	no_button.pressed.connect(handle_action_bar_press.bind(no_button))
	hammer_button.toggled.connect(_on_hammer_button_toggled)
	DataManager.ui_data_updated.connect(on_ui_data_updated)

func _on_resource_missing(variable_name: String) -> void:
	var label = get_node("%" + variable_name.capitalize() + "Text")
	tween_label_error(label)

func tween_label_error(label: Label) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(label, "scale", Vector2(1.5, 1.5), 0.2).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(label, "modulate", Color.RED, 0.1)
	tween.tween_property(label, "scale", Vector2(1, 1), 0.2).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(label, "modulate", Color(1, 1, 1, 1), 0.1)
