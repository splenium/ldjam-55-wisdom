extends MeshInstance3D

@export
var shader_seed: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    material_override.set("shader_parameter/seed", shader_seed);
    pass
