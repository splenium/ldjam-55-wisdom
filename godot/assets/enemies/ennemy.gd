class_name Ennemy extends RigidBody3D

@export var life: int = 5

func take_damage(damage_taken: int) -> int:
	life -= damage_taken
	if life <= 0:
		died()
	return life

func died() -> void:
	queue_free()
