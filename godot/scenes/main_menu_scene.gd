extends Node2D

@export var game_scene: PackedScene;

func _on_play_pressed() -> void:
    get_tree().change_scene(game_scene);
