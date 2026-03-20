class_name RangeTimer
extends Timer
## Provides a simple timer extension that will pick a random time constrained by a min/man time range
##
## Note this must ALWAYS be marked a one-shot timer in Godot settings, as we need to reset the wait
## time after evert timeout so ti can be raandomized


## Mininmum amount of time to wait
@export var min_wait_time: float = 0.0

## Maximum amount of time to wait
@export var max_wait_time: float = 1.0


func _ready() -> void:
	# timer is always one-shot for underlying, we make it repeating by 
	one_shot = true
	timeout.connect( func(): start( pick_wait_time() ) )
	if autostart:
		start( pick_wait_time() )
	

## Set a time range and start the timer
func start_in_range( min_wait: float, max_wait: float ) -> void:
	min_wait_time = min_wait
	max_wait_time = max_wait
	if not is_stopped():
		stop()
	start( pick_wait_time() )


## Return a random amount of time to wait, by default between min_wait_time and max_wait_time
func pick_wait_time() -> float:
	return randf_range(min_wait_time, max_wait_time)
