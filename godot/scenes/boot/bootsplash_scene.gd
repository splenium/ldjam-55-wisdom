class_name BootsplashScene
extends Control

@export var fade_duration: float = 1.0
@export var stay_duration: float = 1.5
@export var node: PackedScene
@export var next_scene: PackedScene
@export var interuptable: bool = true

@onready var control: Control = %NodeContainer
@onready var instance: Node2D = node.instantiate()

func _ready() -> void:
    instance.modulate.a = 0.0
    control.add_child(instance)
    var tween: Tween = create_tween()
    tween.set_trans(Tween.TRANS_CUBIC)
    tween.set_ease(Tween.EASE_IN)
    tween.tween_property(instance, "modulate:a", 1.0, fade_duration)\
    .from(0.0)\
    .finished.connect(_fade_out)

func _fade_out() -> void:
    var tween: Tween = create_tween()
    tween.set_trans(Tween.TRANS_CUBIC)
    tween.set_ease(Tween.EASE_IN)
    tween.tween_property(instance, "modulate:a", 0.0, fade_duration)\
    .set_delay(stay_duration)\
    .finished.connect(_change_scene)

func _change_scene() -> void:
    get_tree().change_scene_to_packed(next_scene)
