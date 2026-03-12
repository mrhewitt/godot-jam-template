extends Node
## Autoload to assist playing AudioStreamResources over SFX bus
##
## Used primarily to play game SFX, use MusicPLayer for background music
## Has additional helper functions for applying common bus controls like volume
## that can be applied to any bus (its here in one place as its senseless to
## dupliate and makes audio UI controls cumbersome if each bus has its own code)

## Default bus used by this player
const AUDIO_BUS = 'SFX'

## Emitted when is set on a particular audio bus 
signal volume_changed( bus: String, volume: float)


## Mute game sound effects bus (not music)
var mute: bool = false:
	set(_mute): 
		mute = _mute
		var audio_bus_idx: int = AudioServer.get_bus_index(AUDIO_BUS)
		AudioServer.set_bus_mute(audio_bus_idx, mute)


## Play a particular sound effect resource
## [param bus_override] optionally used to override main SFX bus to use an alternate
func play( sfx: AudioStreamResource, bus_override: String = "" ) -> void:
	play_stream( sfx.get_audio_stream_to_play(), null, bus_override )


func play_to_node( sfx: AudioStreamResource, parent: Node ) -> void:
	play_stream( sfx.get_audio_stream_to_play(), parent )


func play_stream(sound_to_play: AudioStream, parent: Node = null, bus_override: String = "" ) -> void:
	# do nothing if sfx off, dont waste performance playing unheard sounds
	if mute:
		return
	
	# create a new audio player and put it in the scene
	# if you forgot to add_child() to incklude it in a scene
	# your sound will not play 
	var stream = AudioStreamPlayer.new()
	if parent == null:
		get_tree().get_current_scene().add_child(stream)
	else:
		parent.add_child(stream)
	# tell it to start playing the sound we chose
	stream.bus = AUDIO_BUS if bus_override == "" else bus_override
	stream.stream = sound_to_play
	stream.play() 
	# wait for "finished" signal so we can know when it is done
	await stream.finished
	# delete sound player from scene so finished players dont simply continue to pile up
	stream.queue_free()


## Sets the volume of the given bus
## [param volume] should range from 0.0 (mute) to 1.0 (full volume). 
func set_bus_volume(bus: String, volume: float) -> void:
	volume = clamp(volume,0.0,1.0)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(bus), volume)
	volume_changed.emit(bus, volume)


## Returns the volume set on the bus 
func get_bus_volume(bus: String) -> float:
	return AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(bus))
