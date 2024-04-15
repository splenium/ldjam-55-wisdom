extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if GameManager.player != null:
		if body is Sheep:
			GameManager.player.remove_sheep(body)
	if body is Ennemy:
		body.died()
