extends Control

func _ready() -> void :
	AudioMenuPlayer.play_music_level();
	
func _on_button_pressed() -> void:
	AudioMenuPlayer.play_baiiii_sound();
	get_tree().change_scene_to_file("res://scenes/main_menu_scene.tscn")
