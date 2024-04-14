class_name Multiplicator extends Area3D

@export var speed: float = 0.5
@export var modificator: int = 2

func _ready() -> void:
	var label3D := get_node("Label3D")
	var symbol := "×"
	if modificator < 0:
		symbol = "÷"
	if label3D is Label3D:
		label3D.text = symbol + str(abs(modificator))
	pass

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player: Player = body;
		player.apply_sheep_multiplicator(modificator)
		GameManager.PlaySound("PassPortal")
		self.queue_free()
	pass
