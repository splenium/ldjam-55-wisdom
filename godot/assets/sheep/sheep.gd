class_name Sheep extends RigidBody3D

@export var target: Node3D
@export var speed: float = 10
@export var squeesh: Squeesh

var isFalling:=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if squeesh:
		squeesh.seed = randf() * 100
	pass # Replace with function body.

func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	target_dir.y = 0
	state.apply_force(target_dir * speed)

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if target && is_instance_valid(target):
		# Calculer la direction vers la cible
		#var direction = (target.transform.origin - state.transform.origin).normalized()
		# Appliquer une force vers la cible
		#var force = direction * force_magnitude
		#state.add_central_force(force)
		look_follow(state, global_transform, target.global_transform.origin)
		if global_position.y < 0.0 and state.linear_velocity.y < 0.0 and not isFalling:
			GameManager.PlaySound("Falling")
			isFalling = true
	pass

func die() -> void:
	GameManager.PlaySound("Die")
	queue_free()
