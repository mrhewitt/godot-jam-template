class_name ControlAnimation
extends Node
## Composable node simplying/automating application of tween effects on Control nodes
##

enum TweenAnimations { PULSE }

## Node to apply effect to, default to parent
@export var target: Control = null

## 
@export var animation: TweenAnimations = TweenAnimations.PULSE


func _ready() -> void:
	if target == null:
		target = get_parent()
		
	TweenHelper.set_pivot_center(target)
	start_animation( animation )
	
	
func start_animation( type: TweenAnimations ) -> void:
	match type:
		TweenAnimations.PULSE:
			TweenHelper.pulse(target)
		
		
