extends AudioStreamPlayer2D

var music_menu: AudioStreamMP3 = preload("res://music/menu/peritune_material_ominous.mp3");
var baiiii_sound: AudioStreamMP3 = preload("res://music/sounds/baiiii.mp3");

func _play_music(music: AudioStream, volume: float = 0.0) -> void:
	if stream == music:
		return
		
	stream = music;
	volume_db = volume;
	play()
	
func _stop_music(music: AudioStream) -> void:
	stream = music;
	
	stop()
	
func play_music_level() -> void:
	_play_music(music_menu)
	
func stop_menu_level() -> void:
	_stop_music(music_menu)

func play_baiiii_sound() -> void :
	var audio_player : AudioStreamPlayer = AudioStreamPlayer.new()
	audio_player.stream = baiiii_sound
	add_child(audio_player)
	audio_player.play()
	
	await audio_player.finished
	audio_player.queue_free()
