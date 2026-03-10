extends UIScreen


## Set to true if the quit button must appear
@export var show_quit_button: bool = false

@onready var quit_button: Button = %QuitButton
	

func _ready() -> void:
	quit_button.visible = show_quit_button
	
	
func _on_close_button_pressed() -> void:
	queue_free()
	Game.unpause()


func _on_quit_button_pressed() -> void:
	queue_free()
	Game.unpause()
	
