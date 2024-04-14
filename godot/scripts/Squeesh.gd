class_name Squeesh extends Node3D

@export
var seed: int = 0

@export
var speed: float = 1.0

@export
var scaleFactor: float = 1.2

var originalYScale: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    originalYScale = scale.y

var totalTime: float = 0.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    scale.y = originalYScale * lerp(1.,scaleFactor, sin(totalTime+seed)*0.5+0.5)
    totalTime += delta*speed

