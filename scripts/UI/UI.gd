extends CanvasLayer

signal deployable_passed(deployable : DeployableResource)
signal day_advanced

@export var build_bar: PanelContainer

##building_buttons
@export var barley_button: Button
@export var dates_button: Button
@export var goat_button: Button
@export var camel_button: Button
@export var farm_button: Button

@export var end_day_button: Button
@export var popup_panel: Control
@export var yes_button: Button
@export var no_button: Button

@export var barley_resource : Growable 
@export var dates_resource : Growable
@export var goat_resource : Growable
@export var camel_resource : Growable
@export var farm_resource : Building


@onready var calendar_text: Label = %CalendarText
@onready var coin_text: Label = %CoinText
@onready var wood_text: Label = %WoodText
@onready var stone_text: Label = %StoneText
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var water_text: Label = %WaterText

func _ready() -> void:
	popup_panel.hide()
	barley_button.pressed.connect(handle_action_bar_press.bind(barley_button))
	dates_button.pressed.connect(handle_action_bar_press.bind(dates_button))
	goat_button.pressed.connect(handle_action_bar_press.bind(goat_button))
	camel_button.pressed.connect(handle_action_bar_press.bind(camel_button))
	farm_button.pressed.connect(handle_action_bar_press.bind(farm_button))
	end_day_button.pressed.connect(handle_action_bar_press.bind(end_day_button))
	yes_button.pressed.connect(handle_action_bar_press.bind(yes_button))
	no_button.pressed.connect(handle_action_bar_press.bind(no_button))
	
func _process(_delta: float) -> void:
	calendar_text.text = str(DataManager.calendar)
	coin_text.text = str(DataManager.coins)
	wood_text.text = str(DataManager.wood)
	stone_text.text = str(DataManager.stone)
	water_text.text = str(DataManager.water) + " / 10"
	progress_bar.value = DataManager.water
		
func handle_action_bar_press(button_pressed) -> void:
	match button_pressed:
		barley_button:
			deploy(barley_resource)
		dates_button:
			deploy(dates_resource)
		goat_button:
			print("goat")
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

func deploy(resource):
	deployable_passed.emit(resource)

func check_end_day():
	popup_panel.show()
