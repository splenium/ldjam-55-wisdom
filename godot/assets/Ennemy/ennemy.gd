class_name Ennemy extends Node3D

@export var speed: float = 15
@export var life: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.player != null:
		# Do it better
		self.position.x = GameManager.player.position.x
	self.position.z += delta * GameManager.world_speed
	pass

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print_debug("GAME OVER")
	elif body is KamikazeSheep:
		body.explode()
	elif body is Sheep and GameManager.player != null:
		GameManager.player.remove_sheep(body)
		life -= 1
	elif body is Explosion:
		life -= body.damage
	if life == 0:
			queue_free()
	pass
