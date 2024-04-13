class_name Bonus extends Area3D

@export var speed: float = 0.5
@export var modificator: int = 5

# Called when the node enters the scene tree for the first timeReplace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d: float) ->  void:
	self.position.z += GameManager.world_speed * d
	pass

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player: Player = body;
		player.apply_sheep_modificator(modificator)
		self.queue_free()
	pass
