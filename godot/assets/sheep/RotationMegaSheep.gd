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
func _process(delta: float) -> void:
	var factor: = asin(sin(totalTime*speed+offsetTime))
	
	if abs(factor) > 1.5 and not triggeredSound:
		GameManager.PlaySound("BoomWalk")
		triggeredSound = true
	if abs(factor) < 0.1:
		triggeredSound = false
	set_rotation(Vector3(rotation.x, rotation.y, factor*amplitude))
	totalTime += delta
	pass
