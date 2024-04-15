extends Node2D

@export var game_scene: PackedScene;

@onready var button_v_box: VBoxContainer = %VBoxContainerBoutons;

func _ready() -> void :
	AudioMenuPlayer.play_music_level();
	focus_button()
	
func _on_play_pressed() -> void:
	AudioMenuPlayer.play_baiiii_sound();
	AudioMenuPlayer.stop_menu_level();
	GameManager.next_level()

func focus_button() -> void :
	var button: Button = get_node("UI/VBoxContainerBoutons/Play");
	if button is Button :
		button.grab_focus()

func _on_credits_focus_entered() -> void:
	for child in get_node("UI/VBoxContainerBoutons/Credits").get_children():
		child.visible = true

func _on_credits_focus_exited() -> void:
	for child in get_node("UI/VBoxContainerBoutons/Credits").get_children():
		child.visible = false

func _on_play_focus_entered() -> void:
	for child in get_node("UI/VBoxContainerBoutons/Play").get_children():
		child.visible = true

func _on_play_focus_exited() -> void:
	for child in get_node("UI/VBoxContainerBoutons/Play").get_children():
		child.visible = false

func _on_credits_pressed() -> void:
	AudioMenuPlayer.play_baiiii_sound();
	get_tree().change_scene_to_file("res://scenes/ui/credit_scene.tscn")
