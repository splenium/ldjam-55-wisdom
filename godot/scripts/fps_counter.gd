extends Node

@export var label: Label

func _ready() -> void:
	assert(label != null, "label is null on " + name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text = "FPS : " + str(Engine.get_frames_per_second())
