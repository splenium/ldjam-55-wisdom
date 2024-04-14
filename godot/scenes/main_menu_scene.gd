extends Node2D

@export var game_scene: PackedScene;

@onready var button_v_box: VBoxContainer = %VBoxContainerBoutons;

var next_scene: PackedScene = game_scene;

func _ready() -> void :
	focus_button()
	
func _on_play_pressed() -> void:
	next_scene = game_scene;
	get_tree().change_scene_to_packed(next_scene);

func focus_button() -> void :
	var button: Button = button_v_box.get_child(0);
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
