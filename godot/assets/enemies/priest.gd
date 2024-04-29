class_name Priest extends Ennemy

@export var speed: float = 25.0
var force_needed_for_constant_force: float = 9.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if GameManager.player != null:
		look_follow(state, self.global_transform, GameManager.player.global_transform.origin)
	pass
	
func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	target_dir.y = 0
	target_dir.z = 0
	state.apply_force(target_dir * speed)
	#move_and_collide(target_dir * speed)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.die()
	elif body is KamikazeSheep or body is KamikazeDetectorArea:
		body.explode(self)
	elif body is Sheep and GameManager.player != null:
		GameManager.player.remove_sheep(body)
		life -= 1
	elif body is Explosion:
		body.apply_damage(self)
	if life <= 0:
		queue_free()
	pass
