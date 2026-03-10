@icon("res://addons/jam_template/assets/icons/icon-splash_screen.png")
class_name SplashScreen extends Control

## Emitted when this splash screen is complete and moves on
signal splash_complete


## The amount of time the splash screen should be shown
@export var display_time: float = 0.0

## Set to false if this splash screen is not skippable
@export var skippable: bool = true

var _closed: bool = false


func _ready() -> void:
	set_process_input(false)
	hide()
	visibility_changed.connect(_on_visibility_changed)


func _input(event: InputEvent) -> void:
	if event.is_action_released("skip") and skippable:
		_closed = true
		splash_complete.emit()


func _on_visibility_changed():
	if visible == true:
		set_process_input(true)
		await get_tree().create_timer(display_time).timeout
		if !_closed:
			splash_complete.emit()
	else:
		set_process_input(false)
