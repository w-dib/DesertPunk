extends CanvasLayer

@export var build_bar: PanelContainer
@export var barley_button: Button
@export var dates_button: Button
@export var goat_button: Button
@export var camel_button: Button

func _ready() -> void:
	barley_button.pressed.connect(handle_action_bar_press.bind(barley_button))
	dates_button.pressed.connect(handle_action_bar_press.bind(dates_button))
	goat_button.pressed.connect(handle_action_bar_press.bind(goat_button))
	camel_button.pressed.connect(handle_action_bar_press.bind(camel_button))

func handle_action_bar_press(button_pressed) -> void:
	match button_pressed:
		barley_button:
			print("barley")
		dates_button:
			print("dates")
		goat_button:
			print("goat")
		camel_button:
			print("camel")

func _on_hammer_button_toggled(toggled_on: bool) -> void:
	build_bar.visible = !build_bar.visible
