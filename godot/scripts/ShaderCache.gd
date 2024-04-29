extends Node3D

var count_down := 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if count_down > 0:
		count_down = count_down - 1
		if count_down == 0:
			visible = false
