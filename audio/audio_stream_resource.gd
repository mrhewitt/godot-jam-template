class_name AudioStreamResource extends Resource

@export var audio_file: AudioStream


func get_audio_stream_to_play() -> AudioStream:
	return audio_file
	
	
func play() -> void:
	SoundPlayer.play(self)
