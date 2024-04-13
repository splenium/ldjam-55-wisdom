extends Area3D

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player != null, "player is null" + self.name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is Sheep:
		player.remove_sheep(body)
	pass # Replace with function body.
