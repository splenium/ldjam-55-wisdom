class_name Sheep extends RigidBody3D

@export var target: Node3D
@export var speed: float = 250.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	state.apply_force(target_dir * speed)

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if target:
		# Calculer la direction vers la cible
		#var direction = (target.transform.origin - state.transform.origin).normalized()
		# Appliquer une force vers la cible
		#var force = direction * force_magnitude
		#state.add_central_force(force)
		look_follow(state, global_transform, target.global_transform.origin)
	pass
