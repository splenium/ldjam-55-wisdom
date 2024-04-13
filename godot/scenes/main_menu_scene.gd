extends Node2D

@export var game_scene: PackedScene;

var next_scene: PackedScene = game_scene;

func _on_play_pressed() -> void:
	next_scene = game_scene;
	get_tree().change_scene_to_packed(next_scene);
