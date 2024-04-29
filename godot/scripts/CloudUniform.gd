extends MeshInstance3D

@export
var shader_seed: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material_override.set("shader_parameter/seed", shader_seed)
