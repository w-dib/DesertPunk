extends CanvasLayer

@export var build_bar: PanelContainer

func _on_hammer_button_toggled(toggled_on: bool) -> void:
	build_bar.visible = !build_bar.visible
