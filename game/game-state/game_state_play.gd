class_name GameStatePlay extends GameState

## State to which game will return once game play scene exists
@export var return_state: GameState

## Game module to instantiate when start enters
@export var game_scene: PackedScene

var game_instance: GameScene = null 


func _enter_state() -> void:
	super()
	game_instance = game_scene.instantiate()
	game_instance.goto_return_state.connect( func(): goto_state.emit(return_state) )
	add_child(game_instance)


func _exit_state() -> void:
	super()
	game_instance.queue_free()
	game_instance = null
