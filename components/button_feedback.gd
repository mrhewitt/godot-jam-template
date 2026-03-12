class_name ButtonFeedback extends Node
## Provides a service to add audio/visual feedback to parent or BaseButtons
##

## Set this to the button to attach to if not using parent
@export var attach_to: BaseButton = null

## Sound to play on click, set to override template default
@export var button_click_audio: AudioStreamResource = null

## If set button scale will be set to this value whenever mouse hovers over it
@export var scale_on_hover: float = 0.0

## If set will "pop" the button out on press by the standard pOp tween amount 
@export var pop_on_click: bool = true

## Set this to apply the effects above to all BaseButtons that are siblings of this node
##
@export var attach_to_siblings: bool = false

@export var attach_to_children: bool = false

@export var attach_to_parent_tree: bool = false


func _ready() -> void:
	# if no specific target was specified we operate on our parent provided
	# the parent is a button and not a UIButton (which already implements this as inheritence)
	if attach_to == null and get_parent() is BaseButton and not get_parent() is UIButton:
		attach_to = get_parent()
	
	# if no audio resource was provided default to one in template settings
	if button_click_audio == null:
		button_click_audio = load( ProjectSettings.get(GodotJamTemplatePlugin.SETTINGS_UI_CLOCK_SOUND) )
	
	# if we have a valid direct target, set it up
	if attach_to:
		connect_button(attach_to)

	# now check the special targets ...
	# all non UIButton BaseButton nodes on same level as me
	if attach_to_siblings:
		find_and_connect_sinblings()
		
	# all non UIButton BaseButton nodes any in the tree as descendants of me
	if attach_to_children:
		find_and_connect_children( self )
	
	# all non UIButton BaseButton nodes that are descendants of my parent	
	if attach_to_parent_tree:
		find_and_connect_parent_tree()


## Setup the given button to inctercept events to apply effects
## [color=CORAL]Pivot point will be alter to center if pop or hover scale set[/color]
func connect_button( button: BaseButton ) -> void:
	if pop_on_click or scale_on_hover != 0:
		button.pivot_offset = button.size / 2
	# capture button presses
	button.pressed.connect( _on_pressed.bind(button) )
	
	
func find_and_connect_sinblings() -> void:
	find_and_connect_children( get_parent(), false )
	
	
func find_and_connect_parent_tree() -> void:
	find_and_connect_children( get_parent() )
	
	
func find_and_connect_children( parent: Node, examine_children: bool = true ) -> void:
	for child in parent.get_children():
		if child is BaseButton and not child is UIButton:
			# suitable target so connect it
			connect_button( child )
		# now do all of its children so we can parse the whole tree
		if examine_children:
			find_and_connect_children(child)
	

func _on_pressed( button: BaseButton ) -> void:
	button_click_audio.play()
	if pop_on_click:
		TweenHelper.pop(button)


	
