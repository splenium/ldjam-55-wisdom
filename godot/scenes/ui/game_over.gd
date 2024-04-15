class_name GameOverUi extends Node2D

func _ready() -> void:
	AudioMenuPlayer.play_music_level(); # changer pour gameover music

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_on_button_pressed()

func _on_button_pressed() -> void :
	AudioMenuPlayer.play_baiiii_sound();
	AudioMenuPlayer.stop_menu_level();
	GameManager.reload_level();
