class_name ShaderSceneTransition extends SceneTransitionAbstract
##

## Material defining a shader and its properties to be used in the transition
@export var shader_material: ShaderMaterial

## Name of the propery on the shader material to animate
@export var progress_property: String

## Value in progress property for when transition totally wipes underlying scene
@export var progress_value_closed : float

## Value in progress proepty when underlying scene it totally exposed
@export var progress_value_open: float 


## Applies the transition from a blank screen exposing the underlying scene
func wipe_in( parent: Node ) -> void:
	var layer = _create_color_rect(parent)
	var color_rect:ColorRect = layer.get_child(0)
	
	# set transition to fully closed so entire scene is wiped
	color_rect.set_instance_shader_parameter(progress_property, progress_value_closed)
	
	# animate the transition
	await TweenHelper.tween_shader_property(color_rect, progress_property, progress_value_open, duration).finished
	layer.queue_free()
	
	
## Applies the transition from a full scene to a blank screen
func wipe_out( parent: Node ) -> void:
	var layer = _create_color_rect(parent)
	var color_rect:ColorRect = layer.get_child(0)
	
	# set transition to fully open so entire scene is wiped
	color_rect.set_instance_shader_parameter(progress_property, progress_value_open)
	
	# animate the transition
	await TweenHelper.tween_shader_property(color_rect, progress_property, progress_value_closed, duration).finished
	layer.queue_free()
	
	
## Add the shader material to the underlying color rect 
func _create_color_rect( parent: Node ) -> CanvasLayer:
	var layer := super(parent)
	layer.get_child(0).material = shader_material
	return layer
