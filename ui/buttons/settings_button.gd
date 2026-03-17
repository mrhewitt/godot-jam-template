extends UIButton

## If true setting smenu will include a quit button to return to menu
@export var show_quit_game: bool = false

func _on_pressed() -> void:
	var scene: Node = null
	if show_quit_game:
		# look down tree till we find a game scene
		scene = get_parent()
		while scene and not scene is GameScene2D and not scene is GameScene3D:
			scene = scene.get_parent() 
			
	Game.show_settings( scene ) 
