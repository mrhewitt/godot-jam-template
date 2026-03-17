class_name GameScene3D
extends Node3D


## Emitted when play manager must go to its return state
signal goto_return_state

## Emitted when play manager must go to the named game state
signal goto_state( state: String )

## Emitted when something in this scene has requested to quit
## [br] Usually just trapped by outselves to implement basec quit from settings
signal quit_requested

## Define scene to be shown when [member: pause_menu] is called
@export var pause_menu_scene: PackedScene


func _ready() -> void:
	quit_requested.connect(_on_quit)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_released("pause"):
		Game.show_settings( self )


func pause_menu() -> void:
	pass
	
	
func _on_quit() -> void:
	goto_return_state.emit()
