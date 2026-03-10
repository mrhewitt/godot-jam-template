class_name RandomAudioStreamResource extends AudioStreamResource

## Plays a random sample from this list every time its player via SoundPlayer
@export var audio_list: Array[AudioStream]

## If true audio streams will be be raomdly without repetion until all
## samples have been playeed, at which point it starts again on full list
@export var no_repeats: bool = false

var played_list: Array[int] = []


func get_audio_stream_to_play() -> AudioStream:
	if audio_list.size() == 0:
		return super.get_audio_stream_to_play()
	else: 
		if no_repeats:
			if played_list.size() == 0:
				for i in range(audio_list.size()):
					played_list.append(i)
				played_list.shuffle()
			return audio_list[ played_list.pop_back() ]
		else:	
			return audio_list.pick_random()
