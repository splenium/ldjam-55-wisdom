class_name Explosion extends Area3D

@export var damage := 5

func _process(delta: float) -> void:
    self.position.z += delta * GameManager.world_speed
    pass

func _on_timer_timeout() -> void:
    queue_free() # Replace with function body.
