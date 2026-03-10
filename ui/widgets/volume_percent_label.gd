extends Label

## Audio bus from which to extract volume info
@export var bus: String


func _ready() -> void:
	if AudioServer.get_bus_index(bus) == -1:
		hide()
	else:
		show_volume( SoundPlayer.get_bus_volume(bus) )
		SoundPlayer.volume_changed.connect(_on_volume_changed)


func _on_volume_changed(incoming_bus: String, volume: float):
	if incoming_bus == bus:
		show_volume(volume)


func show_volume(volume: float) -> void:
	text = str(round(volume * 100))
	
