class_name PlayButton extends UIButton

## Link to the game state that controls start of plaay
@export var play_state: GameState


func _on_pressed() -> void:
	play_state.switch_to()
