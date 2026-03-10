@icon("res://addons/jam_template/assets/icons/noun-button-ui-4304285.png")
class_name UIButton extends Button
## Specialized button class the automatically produces a UI click sound
##
## Pressed event is automatically handled, simply override _on_pressed in your code
##

## Sound resource for the feedback sound when pressed
@export var click_sound: AudioStreamResource = preload("uid://bnp8tk31l7xsh")


func _ready() -> void:
	pressed.connect( _play_click )
	pressed.connect( _on_pressed )
	
	
## Plays click sound, override to change this behaviour 	
func _play_click() -> void:
	SoundPlayer.play(click_sound)
	

## Primary handler for the pressed event
func _on_pressed() -> void:
	pass 
