class_name AnimatedTextureRect
extends TextureRect
## Implements a TextureRect that contains frames in same was as a Sprite2D
##
## Using the [param frame] property you can manually alter the frame displayed
## Includes an option for automa 


## Animation speed, how many frames per second to show
@export var frame_rate:int = 5 
				
## If set this animation will play though once, otherwise it will loop
@export var looping: bool = false
	
## Automatically start the animation playing when the visbiility changes
@export var auto_start: bool = true

## Which frame to display from the spritesheet
@export var frame: int = 0:
	set(frame_in):
		if total_frames():
			frame = frame_in % total_frames()
			set_texture_frame(frame)
		else:
			frame = frame_in
			
@onready var frame_height: int = texture.region.size.y
@onready var frame_width: int = texture.region.size.x
@onready var vframes: int = texture.get_atlas().get_height() / frame_height
@onready var hframes: int = texture.get_atlas().get_width() / frame_width

var timer: Timer

func _ready() -> void:
	set_texture_frame(frame)
	visibility_changed.connect( _on_visibility_changed )
	
	# create a timer to animate the frames
	timer = Timer.new()
	timer.one_shot = false
	timer.autostart = false
	timer.timeout.connect( _on_next_frame )
	add_child(timer)
	
	
func play() -> void:
	frame = 0
	timer.start( 1.0/frame_rate)

	
## Display the given frame from the spritesheet in the texture rect[br]
## [param frame_number] is the frame to display, zero-based, automatically wraps around if outside the frame count
func set_texture_frame(frame_number: int) -> void:
	var row: int = frame_number % vframes
	var column: int = frame_number % hframes
	
	texture.region = Rect2( column*frame_width, row*frame_height, frame_width, frame_height)


## Get the total numbere of frames in this spritesheet
func total_frames() -> int:
	return hframes * vframes
	
	
func _on_visibility_changed() -> void:
	if visible and auto_start:
		play()
	else:
		timer.stop()
		
		
func _on_next_frame() -> void:
	# if we were on last frame and its not looping, stop animation 
	if frame + 1 == total_frames() and not looping:
		timer.stop()
	else:
		frame = (frame+1) % total_frames()
	
