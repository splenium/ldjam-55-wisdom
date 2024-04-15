class_name EndLevelPortal extends Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	body.visible = false
	body.process_mode = Node.PROCESS_MODE_DISABLED
	if body is Player:
		GameManager.next_level()
