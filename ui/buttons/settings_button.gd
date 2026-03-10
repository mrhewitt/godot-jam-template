extends UIButton

## If true setting smenu will include a quit button to return to menu
@export var show_quit_game: bool = false

func _on_pressed() -> void:
	Game.show_settings( show_quit_game ) 
