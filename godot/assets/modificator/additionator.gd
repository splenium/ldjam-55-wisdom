class_name Additionator extends Area3D

@export var speed: float = 0.5
@export var sheep_to_add: int = 2

func _ready() -> void:
	var label3D := get_node("Label3D")
	var symbol := "+"
	if sheep_to_add < 0:
		symbol = "-"
	if label3D is Label3D:
		label3D.text = symbol + str(abs(sheep_to_add))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d: float) ->  void:
	self.position.z += GameManager.world_speed * d
	pass

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player: Player = body;
		player.apply_sheep_addition(sheep_to_add)
		GameManager.PlaySound("PassPortal")
		self.queue_free()
	pass
