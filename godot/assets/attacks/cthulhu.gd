class_name Cthulhu extends Area3D

@export var damage := 5
@export var tentaculeScene: PackedScene
@export var timer := Timer

func _on_attack_timer_timeout() -> void:
	var bodies := get_overlapping_bodies()
	if bodies.size() == 0:
		return
	var ennemy: Ennemy = bodies.pick_random()
	if tentaculeScene:
		var tentacule := tentaculeScene.instantiate()
		get_parent().add_child(tentacule)
		tentacule.global_position = ennemy.global_position
	ennemy.take_damage(damage)
	var time: float = 1.0 / bodies.size()
	timer.wait_time = time

func _on_stop_timer_timeout() -> void:
	queue_free()
