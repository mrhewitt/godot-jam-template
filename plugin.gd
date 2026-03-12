@tool
class_name GodotJamTemplatePlugin extends EditorPlugin

## Autoload that handles saving screens of gameplay  
const SCREEN_SHOT = "ScreenShot"
const SFX_PLAYER = "SoundPlayer"
const MUSIC_PLAYER = "MusicPlayer"
const GAME_MANAGER = "Game"

## Path the the default audio bus to configure for the project
const AUDIO_BUS_PATH = "res://addons/jam_template/resources/default_bus_layout.tres"

## Audio resource providing default click sound for buttons
## [br] DO NOT USE THIS DIRECTLY
## [br] Get default sound resource path from proejct settings using SETTINGS_UI_CLOCK_SOUND const
const DEFAULT_UI_CLICK_AUDIO = "res://addons/jam_template/resources/ui_click.tres"

## Path the Project Settings value for getting the path of default audio resource for button clicks
const SETTINGS_UI_CLOCK_SOUND = "plugin/godot_jam_template/ui_click_sound"

## Specials actions automatically setup by the template
const ACTIONS = {
		screenshot = {key = {code = KEY_S, ctrl_pressed = true} },
		pause = { key = {code = KEY_ESCAPE} },
		skip = { key = {code = KEY_SPACE}, mouse = MOUSE_BUTTON_LEFT }
}


func _enable_plugin() -> void:
	# Add autoloads here.
	add_autoload_singleton(SCREEN_SHOT, "res://addons/jam_template/game/screenshot.gd")
	add_autoload_singleton(SFX_PLAYER, "res://addons/jam_template/audio/sound_player.gd")
	add_autoload_singleton(MUSIC_PLAYER, "res://addons/jam_template/audio/music_player.gd")
	add_autoload_singleton(GAME_MANAGER, "res://addons/jam_template/game/game_base.tscn")
	
	add_actions( ACTIONS )
	
	# these are custom Project Settings value specifically for making template easy to use
	# so indivual games can override some things like defualt UI sound etc without needing
	ProjectSettings.set_setting(SETTINGS_UI_CLOCK_SOUND, DEFAULT_UI_CLICK_AUDIO )
	
	ProjectSettings.set_setting("audio/buses/default_bus_layout",AUDIO_BUS_PATH)
	ProjectSettings.save()
	
	
func _disable_plugin() -> void:
	remove_autoload_singleton(SCREEN_SHOT)
	remove_autoload_singleton(SFX_PLAYER)
	remove_autoload_singleton(MUSIC_PLAYER)
	remove_autoload_singleton(GAME_MANAGER)
	
	remove_actions( ACTIONS.keys() )
	
	ProjectSettings.set_setting("audio/buses/default_bus_layout","res://default_bus_layout.tres")
	ProjectSettings.save()
	

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass


func add_actions( actions: Dictionary ) -> void:
	for action in actions:
		add_action( action, actions[action] )


func add_action( action: String, event: Dictionary ) -> void:
	var input_map = {
		"deadzone": 0.2,
		"events": []
	}
	
#	if gamepad_button != JOY_BUTTON_INVALID:
#		var event_gamepad := InputEventJoypadButton.new()
#		event_gamepad.button_index = gamepad_button
#		event_gamepad.device = -1 # All devices
#		input_map["events"].append(event_gamepad)
	
	if event.has('mouse'):
		var event_mouse := InputEventMouseButton.new()
		event_mouse.button_index = event.mouse
		event_mouse.device = -1 # All devices
		input_map["events"].append(event_mouse)

	if event.has('key'):
		var event_key := InputEventKey.new()
		event_key.physical_keycode = event.key.code
		#event_key.mods.ctrl_pressed = event.key.has('çtrl_pressed') and event.key.çtrl_pressed
		input_map["events"].append(event_key)
		
	ProjectSettings.set_setting("input/" + action, input_map)

	
	
func remove_actions( actions: Array ) -> void:
	for action in actions:
		remove_action(action)
		

func remove_action(action: String) -> void:
	ProjectSettings.set_setting("input/" + action, null)
