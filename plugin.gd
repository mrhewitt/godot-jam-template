# ####################################################################################
# ##                   This file is part of Godot Jam Template.                     ##
# ##                 https://github.com/mrhewitt/godot-jam-template                 ##
# ####################################################################################
# ## Copyright (c) 2026 Mark Hewitt                                                 ##
# ##                                                                                ##
# ## Permission is hereby granted, free of charge, to any person obtaining a copy   ##
# ## of this software and associated documentation files (the "Software"), to deal  ##
# ## in the Software without restriction, including without limitation the rights   ##
# ## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      ##
# ## copies of the Software, and to permit persons to whom the Software is          ##
# ## furnished to do so, subject to the following conditions:                       ##
# ##                                                                                ##
# ## The above copyright notice and this permission notice shall be included in all ##
# ## copies or substantial portions of the Software.                                ##
# ##                                                                                ##
# ## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     ##
# ## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       ##
# ## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    ##
# ## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         ##
# ## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  ##
# ## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  ##
# ## SOFTWARE.                                                                      ##
# ####################################################################################

@tool
class_name GodotJamTemplatePlugin extends EditorPlugin

## Autoload that handles saving screens of gameplay  
const SCREEN_SHOT = "ScreenShot"
const SFX_PLAYER = "SoundPlayer"
const MUSIC_PLAYER = "MusicPlayer"
const GAME_MANAGER = "Game"

## Path the the default audio bus to configure for the project
const AUDIO_BUS_PATH = "res://addons/godot-jam-template/resources/default_bus_layout.tres"

## Audio resource providing default click sound for buttons
## [br] DO NOT USE THIS DIRECTLY
## [br] Get default sound resource path from proejct settings using SETTINGS_UI_CLOCK_SOUND const
const DEFAULT_UI_CLICK_AUDIO = "res://addons/godot-jam-template/resources/ui_click.tres"

## Path the Project Settings value for getting the path of default audio resource for button clicks
const SETTINGS_UI_CLOCK_SOUND = "plugin/godot_jam_template/ui_click_sound"

## Specials actions automatically setup by the template
const ACTIONS = {
		screenshot = {key = {code = KEY_S, ctrl_pressed = true} },
		pause = { key = KEY_ESCAPE },
		skip = { key = KEY_SPACE, mouse = MOUSE_BUTTON_LEFT },
		move_up = [ {key = KEY_W}, {key = KEY_UP} ],
		move_down = [ {key = KEY_S}, {key = KEY_DOWN} ],
		move_left = [ {key = KEY_A}, {key = KEY_LEFT} ],
		move_right = [ {key = KEY_D}, {key = KEY_RIGHT} ],
}


func _enable_plugin() -> void:
	# Add autoloads here.
	add_autoload_singleton(SCREEN_SHOT, "res://addons/godot-jam-template/game/screenshot.gd")
	add_autoload_singleton(SFX_PLAYER, "res://addons/godot-jam-template/audio/sound_player.gd")
	add_autoload_singleton(MUSIC_PLAYER, "res://addons/godot-jam-template/audio/music_player.gd")
	add_autoload_singleton(GAME_MANAGER, "res://addons/godot-jam-template/game/game_base.tscn")

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


func add_action( action: String, event ) -> void:
	var input_map = {
		"deadzone": 0.2,
		"events": []
	}
	
#	if gamepad_button != JOY_BUTTON_INVALID:
#		var event_gamepad := InputEventJoypadButton.new()
#		event_gamepad.button_index = gamepad_button
#		event_gamepad.device = -1 # All devices
#		input_map["events"].append(event_gamepad)
	if typeof(event) == TYPE_DICTIONARY:
		_add_to_input_map(event,input_map)
	else:
		for entry in event:
			print("Found entry ", entry)
			_add_to_input_map(entry,input_map)
	ProjectSettings.set_setting("input/" + action, input_map)

	
func _add_to_input_map( event, input_map ) -> void:
	if event.has('mouse'):
		var event_mouse := InputEventMouseButton.new()
		event_mouse.button_index = event.mouse
		event_mouse.device = -1 # All devices
		input_map["events"].append(event_mouse)

	if event.has('key'):
		var event_key := InputEventKey.new()
		if event.key is Dictionary:
			event_key.physical_keycode = event.key.code
			event_key.ctrl_pressed = true # event.key.has('çtrl_pressed') and event.key.çtrl_pressed
		else:
			event_key.physical_keycode = event.key
				
		input_map["events"].append(event_key)

	
func remove_actions( actions: Array ) -> void:
	for action in actions:
		remove_action(action)
		

func remove_action(action: String) -> void:
	ProjectSettings.set_setting("input/" + action, null)
