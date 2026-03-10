class_name GameScene extends Node2D


## Emitted when play manager must go to its return state
signal goto_return_state

## Emitted when play manager must go to the named game state
signal goto_state( state: String )

## Define scene to be shown when [member: pause_menu] is called
@export var pause_menu_scene: PackedScene


func pause_menu() -> void:
	pass
