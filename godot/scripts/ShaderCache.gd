extends Node3D

@export
var count_down := 2

func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if count_down > 0:
		count_down = count_down - 1
		if count_down == 0:
			visible = false
