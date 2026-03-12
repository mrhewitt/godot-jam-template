@icon("res://addons/godot-jam-template/assets/icons/icons8-nodes-60.png")
class_name GameStateMachine extends Node

## Emitted when the state of the game has changed
signal state_changed( from: GameState, to: GameState )

var _current_state: GameState = null


func _ready() -> void:
	# hook up to each states next signal so we can track how to move on
	for child in get_children():
		if child is GameState:
			child._activate_state()
			child.next_state.connect(_on_next_state)
			child.goto_state.connect( switch_to )
		
	# automatically enter first state
	switch_to( get_child(0) )
	
	
func switch_to( state ) -> GameState:
	var next_state  := find_state(state)
	if next_state != _current_state:
		var last_state := _current_state
		if _current_state:
			_current_state._exit_state()
		_current_state = find_state(state)
		_current_state._enter_state()
		state_changed.emit(last_state,_current_state)
	
	return _current_state


func find_state(state) -> GameState:
	if state is GameState:
		return state
	else:
		state = state.to_lower()
		for child in get_children():
			if child.name.to_lower() == state or child.name.to_kebab_case() == state:
				return child
	return null


func _on_next_state( state_completed: GameState ) -> void:
	# find the state the just finished, and the enter its sibling
	for i in get_child_count():
		var child = get_child(i)
		if child == state_completed:
			if i+1 < get_child_count():
				switch_to( get_child(i+1) )
