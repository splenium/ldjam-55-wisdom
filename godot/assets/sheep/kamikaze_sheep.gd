class_name KamikazeSheep extends Sheep

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if target && !is_instance_valid(target):
		target = GameManager.find_nearest_of_player_ennemy()
	if target && is_instance_valid(target):
		print("target is " + target.name)
		super._integrate_forces(state)
	else:
		var fake_target_far: Vector3 = Vector3(0, 0, -1000)
		look_follow(state, global_transform, fake_target_far)

func explode() -> void:
	var explosion: Explosion = preload("res://assets/attacks/explosion.tscn").instantiate()
	get_parent().add_child(explosion)
	explosion.global_transform = global_transform
	queue_free()
