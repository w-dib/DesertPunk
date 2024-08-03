extends Node2D

@onready var tiles: Node = $Tiles
@onready var ui: CanvasLayer = $UI
@onready var preview_manager: Node2D = $PreviewManager
@onready var day_advance_manager: Node = $DayAdvanceManager

func _ready() -> void:
	ui.deployable_passed.connect(_on_ui_deployable_passed)
	ui.day_advanced.connect(_on_day_advanced)

func _on_ui_deployable_passed(deployable: DeployableResource) -> void:
	preview_manager.preview(deployable)
	
func _on_day_advanced() -> void:
	day_advance_manager.advance_day()
