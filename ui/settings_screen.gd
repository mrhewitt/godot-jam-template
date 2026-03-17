extends UIScreen


## Set to true if the quit button must appear
##@export var show_quit_button: bool = false

## If you want quit button to leave a game scene, pass it here[br]
## Normally a GameScene[2|3]D instance, it can be any node that has a [br]
## [i]quit_requested[i] signal to emit
@export var from_game_scene: Node  
	
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	quit_button.visible = from_game_scene != null
	
	
func _on_close_button_pressed() -> void:
	queue_free()
	Game.unpause()


func _on_quit_button_pressed() -> void:
	queue_free()
	if from_game_scene: 
		from_game_scene.quit_requested.emit()
	Game.unpause()
	
