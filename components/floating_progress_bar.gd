class_name FloatingProgressBar extends ProgressBar
##

@export var fade_delay: float = 0.5

@export var fade_time: float = 0.5

@export var attached_to: CanvasItem = null

@export var position_offset: Vector2 = Vector2.ZERO

var _fade_tween: Tween = null


func _ready() -> void:
	if attached_to == null:
		attached_to = get_parent()
	

func set_and_show( new_value ) -> void:
	
	
	# if we showed it again before it had time to fade out just kill
	# the tween and display
	if _fade_tween and _fade_tween.is_running():
		_fade_tween.kill()
		modulate.a = 1.0	# but reset alpha as tween did not have time to do that yet
	
	_fade_tween = null	
	value = new_value
	position = attached_to.position + position_offset
	visible = true
	
	
func fadeout() -> void:
	# only set a fade if we are visible and there is not already one running
	if visible and _fade_tween == null:
		_fade_tween = TweenHelper.fadeout(self,fade_time,fade_delay)
