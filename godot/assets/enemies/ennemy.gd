class_name Ennemy extends RigidBody3D

@export var life: int = 5

func take_damage(damage_taken: int) -> bool:
	life -= damage_taken
	if life <= 0:
		died()
		return true
	return false

func died() -> void:
	queue_free()
