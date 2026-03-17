class_name FadingLabel
extends Label
## Simple Label class that will automatically fade label out after a set delay

## How long to wait before fading
@export var delay: float = 1.0

## How quickly it fades out
@export var fade_time: float = 1.0

	
var fade_tween: Tween


func _ready() -> void:
	visibility_changed.connect( _on_visibility_changed )
	visible = false
	
	
func _on_visibility_changed() -> void:
	if visible:
		if fade_tween and fade_tween.is_running():
			fade_tween.kill()
		fade_tween = TweenHelper.fadeout( self, fade_time, delay )


## Sets label text and shows the control, starting the fade
func show_text( msg: String ) -> void:
	text = msg
	visible = true
