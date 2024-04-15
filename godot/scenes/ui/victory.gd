class_name Victory extends Node2D

func _ready() -> void:
	AudioMenuPlayer.play_music_level(); # changer pour victory music

func _on_button_pressed() -> void :
	AudioMenuPlayer.play_baiiii_sound();
	AudioMenuPlayer.stop_menu_level();
	GameManager.load_start_menu();
