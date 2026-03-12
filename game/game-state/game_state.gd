@icon("res://addons/godot-jam-template/assets/icons/icons8-gears-50.png")
class_name GameState extends Node

## Emitted when this state is "complete" and wants to request game
## state machine move onto the next state in sequence 
signal next_state(state_completed: GameState)

## Emitted when a state wants to swith to another state
signal goto_state( state )

## Optional music track to play on entering this state
## Will play on _enter_state and stop on _exit_state
@export var state_music: AudioStreamResource = null

## Set a transition to play when this state is entered
@export var enter_transition: SceneTransitionAbstract = null

## Set a transition to show when exiting the state
@export var exit_transition: SceneTransitionAbstract = null

var _state_machine: GameStateMachine = null


func switch_to() -> void:
	goto_state.emit(self)
	

func _enter_state() -> void:
	if state_music != null:
		MusicPlayer.play(state_music)
	if enter_transition != null:
		await enter_transition.wipe_in(self)
	
	
func _exit_state() -> void:
	if exit_transition != null:
		await exit_transition.wipe_out(self)
	if state_music != null:
		MusicPlayer.stop()

	
## Called when the [State] is added to a [StateMachine].
## This should be used for initialization instead of _ready() because it is
## guaranteed to be run [i]after[/i] all of the nodes that are in the owner's 
## tree have been constructed - preventing race conditions.
## [br][br][color=yellow][b]WARNING:[/b][/color]
## [br]When overriding, be sure to call [method super] on the first line of your method.
## [br][i]Never[/i] call this method directly. It should only be used by the [StateMachine]
func _activate_state() -> void:
	_state_machine = get_parent()
#	_state_machine_name = _state_machine.name
	#_subject_name = _state_machine.subject.name
	#if _state_machine.print_state_changes:
	#	print_rich("[color=forest_green][b]Activate[/b][/color] [color=gold][b]%s[/b][/color] [color=ivory]%s State:[/color] [color=forest_green]%s[/color]" % [_subject_name, _state_machine_name, self.name])
