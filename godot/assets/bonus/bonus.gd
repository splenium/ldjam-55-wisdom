class_name Bonus extends Area2D

@export var speed: float = 100.0
@export var bonus: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d: float) ->  void:
    self.position.y += speed * d
    pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    self.queue_free()
    pass

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        var player: Player = body;
        player.sheepNumber *= bonus
    self.queue_free()
