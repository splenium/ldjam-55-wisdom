class_name MegaSheep extends Sheep

@export var life := 100

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var fake_target_far: Vector3 = Vector3(0, 0, -1000)
	look_follow(state, global_transform, fake_target_far)
	pass

func died() -> void:
	queue_free()
	
func _exit_tree() -> void:
	pass

func _on_damage_area_body_entered(body: Node3D) -> void:
	if body is Ennemy:
		life -= body.life
		body.take_damage(life)
		if life <= 0:
			died()
	pass # Replace with function body.
