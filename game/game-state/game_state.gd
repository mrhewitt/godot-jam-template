@icon("res://addons/jam_template/assets/icons/icons8-gears-50.png")
class_name GameState extends Node

## Emitted when this state is "complete" and wants to request game
## state machine move onto the next state in sequence 
signal next_state(state_completed: GameState)

## Emitted when a state wants to swith to another state
signal goto_state( state )

var _state_machine: GameStateMachine = null


func switch_to() -> void:
	goto_state.emit(self)
	

func _enter_state() -> void:
	pass
	
	
func _exit_state() -> void:
	pass
	
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
