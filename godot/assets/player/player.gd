class_name Player extends CharacterBody2D

@export var speed: float = 500.0
@export var sheepNumber: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d: float) -> void:
    move(d)
    pass
    
func move(d: float) -> void:
    if Input.is_action_pressed("ui_left"):
        self.position.x -= speed * d
    if Input.is_action_pressed("ui_right"):
        self.position.x += speed * d
    pass
