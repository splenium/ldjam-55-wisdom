extends Node3D

@export var speed: float = 1.0
@export var amplitude: float = 1.0
@export var offsetTime: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var totalTime: = 0.
var triggeredSound : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
#func _process(delta: float) -> void:
	var factor: = asin(sin(totalTime*speed+offsetTime))
	
	if abs(factor) > 1.5 and not triggeredSound:
		GameManager.PlaySound("BoomWalk")
		shakeScreen()
		triggeredSound = true
	if abs(factor) < 0.1:
		triggeredSound = false
	set_rotation(Vector3(rotation.x, rotation.y, factor*amplitude))
	totalTime += delta
	pass

func shakeScreen() -> void:
	var step: = 1. /30.
	var duration: = 0.3
	var curTime: = 0.
	var PostFXRect:ColorRect = get_tree().get_nodes_in_group("PostFXRect")[0]
	while true:
		PostFXRect.material.set("shader_parameter/Shake", 1 - curTime / duration) 
		curTime += step
		await get_tree().create_timer(step).timeout
		if curTime > duration:
			break
	PostFXRect.material.set("shader_parameter/Shake", 0.) 
	
func _exit_tree() -> void:
	var PostFXRect:ColorRect = get_tree().get_nodes_in_group("PostFXRect")[0]
	PostFXRect.material.set("shader_parameter/Shake", 0.) 
