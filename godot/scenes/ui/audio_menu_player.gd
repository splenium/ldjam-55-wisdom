extends AudioStreamPlayer2D

var music_menue: AudioStreamMP3 = preload("res://music/menu/peritune_material_ominous.mp3");

func _play_music(music: AudioStream, volume: float = 0.0) -> void:
	if stream == music:
		return
		
	stream = music;
	volume_db = volume;
	play()
	
func play_music_level() -> void:
	_play_music(music_menue)
