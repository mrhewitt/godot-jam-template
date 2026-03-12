extends UIScreen


## Set to true if the quit button must appear
##@export var show_quit_button: bool = false

## If you want quit button to leave a game scene, pass it here
@export var from_game_scene: GameScene  
	
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
	
