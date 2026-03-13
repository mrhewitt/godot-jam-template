class_name SceneTransitionAbstract extends Resource
##

## Duration of the transition
@export var duration: float = 1.0

## Set to use default project clear color instead of empty color
@export var use_default_clear_color: bool = true

## Color to be used as the clear color (wiping the scene) when applying the transition
@export var clear_color: Color


## Applies the transition from a blank screen exposing the underlying scene
func wipe_in( parent: Node ) -> void:
	pass
	
	
## Applies the transition from a full scene to a blank screen
func wipe_out( parent: Node ) -> void:
	pass
	

## Creates a color rect over the underlying node on top of a CanvasLayer[br]
## with a high layer value so we also wipe any ui canvas layer
func _create_color_rect( parent: Node ) -> CanvasLayer:
	var layer = CanvasLayer.new()
	layer.layer = 101
	# add a color rect to apply effect over
	var color_rect = ColorRect.new()
	color_rect.color = _get_clear_color()
	# size to viewport as FULL_RECT anchors wont work outside a positional node
	color_rect.custom_minimum_size = parent.get_viewport().size
	# let mouse pass though so player can interact while it animates
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(color_rect)
	parent.add_child(layer)
	return layer
	
	
func _get_clear_color() -> Color:
	if use_default_clear_color:
		return ProjectSettings.get_setting("rendering/environment/defaults/default_clear_color")
	else:
		return clear_color
