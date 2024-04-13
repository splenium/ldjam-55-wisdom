extends Node2D

@onready var overlay: FadeOverlay = %FadeOverlay
@onready var continue_button: Button = %ContinueButton

var new_game: bool = true

func _ready() -> void:
	overlay.visible = true

#
#func _on_fade_overlay_on_complete_fade_out() -> void:
	#get_tree().change_scene_to_packed(next_scene)
