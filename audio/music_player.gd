extends Node
## Autoload to assist playing AudioStreamResources over Music bus
##
## Requires addition of a bus "Music" to your default audio bus setup
##
## Used primarily to play game SFX, use MusicPLayer for background music
## Has additional helper functions for applying common bus controls like volume
## that can be applied to any bus (its here in one place as its senseless to
## dupliate and makes audio UI controls cumbersome if each bus has its own code)

const AUDIÖ_BUS = 'Music'

var mute: bool = false:
	set(_mute): 
		mute = _mute
		var audio_bus_idx: int = AudioServer.get_bus_index(AUDIÖ_BUS)
		AudioServer.set_bus_mute(audio_bus_idx, mute)		
		if _music_audio_player != null:
			if mute:			
				_music_audio_player.stop()  # stop current music track if we are muted
			else:			
				_music_audio_player.play()	 # start current music again now we are unmuted
			
var _music_audio_player: AudioStreamPlayer = null
## Instance of audio resource past to play_all so we can keep accessing it
var _current_track_list: AudioStreamResource = null


func play( audio: AudioStreamResource, looping: bool = true ) -> void:
	_play_stream( audio.get_audio_stream_to_play(), looping)


## Plays all tracks in the given stream, picking a different one each time
## Works best with a RandomAudioStreamResource with no_repeats set
func play_all( audio: AudioStreamResource ) -> void:
	_current_track_list = audio
	_play_from_current()


## Stops any music currently playing and frees the player instance
func stop() -> void:
	if _music_audio_player == null:
		_music_audio_player.stop()
		_music_audio_player.queue_free()


func _play_from_current() -> void:
	_play_stream( _current_track_list.get_audio_stream_to_play(), false)
	# when music is done, loop back to play another random game track
	_music_audio_player.connect("finished", _play_from_current)
	
	
func _play_stream(sound_to_play: AudioStream, loop: bool = true) -> void:
	# create a new audio player and put it in the scene
	# if you forgot to add_child() to incklude it in a scene
	# your sound will not play 
	if _music_audio_player == null:
		_music_audio_player = AudioStreamPlayer.new()
		get_tree().get_current_scene().add_child.call_deferred(_music_audio_player)
		# tell it to start playing the sound we chose
		_music_audio_player.bus = AUDIÖ_BUS
		if loop:
			_music_audio_player.connect("finished", _on_music_finished)
		
	_music_audio_player.stream = sound_to_play
	# only start it actually playing if we are not muted
	if !mute:
		_music_audio_player.play.call_deferred() 
	
	
func _on_music_finished() -> void:
	_music_audio_player.play()
