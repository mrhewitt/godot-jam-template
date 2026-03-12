class_name GameBase extends Node
##
##

const SETTINGS_SCREEN = preload("uid://dc1xd170yfvm8")

## Primary state machine used to control flow of outer game elements
var game_state_machine: GameStateMachine


## Show/hide the settings overlay and pause/resume game
## [br]Set [param game_scene] for a quit button to leave game play state
func show_settings( game_scene: GameScene = null ) -> void:
	pause() 

	var instance = SETTINGS_SCREEN.instantiate()
	instance.from_game_scene = game_scene
	get_tree().root.add_child(instance)
	
	
## Pause the game
func pause(pause: bool = true) -> void:
	get_tree().paused = pause


## Unpauses the game.
## [br]Convenience method.
func unpause() -> void:
	pause(false)
	

## Toggles pause state between paused and unpaused
func toggle_paused() -> void:
	pause( not is_paused())
 

## Returns whether or not the game is paused.
## [br]Convenience method.
func is_paused() -> bool:
	return get_tree().paused


## Helper to quit game properly, sends window close notification before scene tree quit
func quit() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
