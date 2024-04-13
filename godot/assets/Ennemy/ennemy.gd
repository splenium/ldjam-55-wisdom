extends Node

@export var target: Node3D
@export var speed: float = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.z += delta * speed
	pass


func _on_body_entered(body: Node3D) -> void:
	#if body is Player:
		#var 
	pass # Replace with function body.
