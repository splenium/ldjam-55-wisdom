class_name Cthulhu extends Area3D

@export var damage := 5
@export var tentaculeScene: PackedScene
@export var timer := Timer
@export var krakenMesh := MeshInstance3D

func _ready() -> void:
	GameManager.PlaySound("Tentacles")
	GameManager.PlaySound("Braam")

	
	var step: = 1. /30.
	var duration: = 1.
	var curTime: = 0.
	var PostFXRect:ColorRect = get_tree().get_nodes_in_group("PostFXRect")[0]
	while true:
		PostFXRect.material.set("shader_parameter/kraken", curTime / duration) 
		krakenMesh.material_override.set("shader_parameter/kraken", curTime / duration) 
		curTime += step
		await get_tree().create_timer(step).timeout
		if curTime > duration:
			break
	PostFXRect.material.set("shader_parameter/kraken", 1.) 
	krakenMesh.material_override.set("shader_parameter/kraken", 1.) 

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
	var step: = 1. /30.
	var duration: = 1.
	var curTime: = 0.
	var PostFXRect:ColorRect = get_tree().get_nodes_in_group("PostFXRect")[0]
	while true:
		PostFXRect.material.set("shader_parameter/kraken", 1 - curTime / duration) 
		krakenMesh.material_override.set("shader_parameter/kraken", 1 - curTime / duration) 
		curTime += step
		await get_tree().create_timer(step).timeout
		if curTime > duration:
			break
	PostFXRect.material.set("shader_parameter/kraken", 0.) 
	krakenMesh.material_override.set("shader_parameter/kraken", 0.) 
	queue_free()
