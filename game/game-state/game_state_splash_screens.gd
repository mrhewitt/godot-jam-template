class_name GameStateSplashScreens extends GameState


var _current_screen: int = 0

func _ready() -> void:
	# hook up to each splash screen so we can move on after each one is done
	for child in get_children():
		if child is SplashScreen:
			child.splash_complete.connect(_on_splash_complete)


func _enter_state() -> void:
	super()
	get_child(_current_screen).show()


func _on_splash_complete() -> void:
	get_child(_current_screen).hide()
	_current_screen += 1
	if get_child_count() == _current_screen:
		next_state.emit(self)
	else:
		get_child(_current_screen).show()
