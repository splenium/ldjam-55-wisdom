class_name Explosion extends Area3D

@export var damage := 15

func _ready() -> void:
	GameManager.PlaySound("Bomb")

func _physics_process(delta: float) -> void:
	self.position.z += delta * GameManager.world_speed
	pass

func _on_timer_timeout() -> void:
	queue_free() # Replace with function body.
	
func apply_damage(ennemy: Ennemy) -> void:
	if damage <= 0:
		return;
	if ennemy.life > damage:
		ennemy.life -= damage
		damage = 0
	else:
		damage -= ennemy.life
		ennemy.life = 0
		ennemy.queue_free()
