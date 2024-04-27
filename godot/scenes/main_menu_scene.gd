extends Node2D

@export var game_scene: PackedScene;

@onready var button_v_box: VBoxContainer = %VBoxContainerBoutons;

func credit_focused() -> void:
	for child in get_node("UI/VBoxContainerBoutons/Credits").get_children():
		child.visible = true

func credit_unfocused() -> void:
	for child in get_node("UI/VBoxContainerBoutons/Credits").get_children():
		child.visible = false

func play_focused() -> void:
	for child in get_node("UI/VBoxContainerBoutons/Play").get_children():
		child.visible = true

func play_unfocused() -> void:
	for child in get_node("UI/VBoxContainerBoutons/Play").get_children():
		child.visible = false

func focus_player() -> void :
	var button: Button = get_node("UI/VBoxContainerBoutons/Play");
	if button is Button :
		button.grab_focus()

func focus_credit() -> void :
	var button: Button = get_node("UI/VBoxContainerBoutons/Credits");
	if button is Button :
		button.grab_focus()

func _ready() -> void :
	AudioMenuPlayer.play_music_level();
	focus_player()
	
func _on_play_pressed() -> void:
	AudioMenuPlayer.play_baiiii_sound();
	get_tree().change_scene_to_file("res://scenes/ui/intro/intro_scene.tscn")

func _on_credits_focus_entered() -> void:
	credit_focused()

func _on_credits_focus_exited() -> void:
	credit_unfocused()

func _on_play_focus_entered() -> void:
	play_focused()

func _on_play_focus_exited() -> void:
	play_unfocused()

func _on_credits_pressed() -> void:
	AudioMenuPlayer.play_baiiii_sound();
	get_tree().change_scene_to_file("res://scenes/ui/credit_scene.tscn")

func _on_play_mouse_entered() -> void:
	focus_player()

func _on_credits_mouse_entered() -> void:
	focus_credit()
