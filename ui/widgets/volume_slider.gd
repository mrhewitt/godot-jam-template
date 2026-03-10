class_name VolumeSlider extends HSlider

## How long to wait before playing confirm sound again is using ui_xxx inputs to update slider
const UI_COOLDOWN = 0.2

## Which audio bus this slider will control
@export var bus: String

## Sound to play to confirm the volume
@export var confirmed_sound: AudioStreamResource = preload("uid://d1ldd1bv1pasb")

var ui_input_cooldown: Timer


func _ready() -> void:
	# do not show this if we dont have a bus for it in default audio bus setup
	if AudioServer.get_bus_index(bus) == -1:
		hide()
	else:
		min_value = 0.0
		max_value = 1.0
		step = 0.05
		custom_minimum_size.x = 150.0
		value = SoundPlayer.get_bus_volume(bus)
		
		self.value_changed.connect(_on_value_changed)
		self.gui_input.connect(_on_gui_input)
		
		ui_input_cooldown = Timer.new()
		ui_input_cooldown.one_shot = true
		ui_input_cooldown.wait_time = UI_COOLDOWN
		add_child(ui_input_cooldown)


func _on_value_changed(new_volume: float) -> void:
	SoundPlayer.set_bus_volume(bus, new_volume)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_released():
		SoundPlayer.play(confirmed_sound, bus)
	if event.is_action_released("ui_left") or event.is_action_released("ui_right"):
		if ui_input_cooldown.is_stopped():
			SoundPlayer.play_volume_confirm_sound(bus)
			ui_input_cooldown.start()
