class_name PathGenerator extends Node3D

@export var spawn_z := -40.0
@export var despawn_z := 15.0
var first_spawn_position := Vector3(0, 0, despawn_z)
@export var path_width := 10.0

@export var speed := 4.0

@export var paths: Array[Node3D] = []

func _ready() -> void:
    var last_path: Node3D = null
    while (last_path == null || last_path.global_position.z > spawn_z):
        spawn_path()
        last_path = paths[paths.size() - 1]

func _process(delta: float) -> void:
    shift_paths(delta)
    var last_path := paths[paths.size() - 1]
    if last_path.global_position.z > spawn_z:
        spawn_path()
    if paths.size() > 1 and paths[0].global_position.z > despawn_z:
        paths[0].queue_free()
        paths.pop_front()

func spawn_path() -> void:
    var new_path := preload("res://assets/corridor/path_tile.tscn").instantiate()
    add_child(new_path)
    if paths.size() == 0:
      new_path.global_position = first_spawn_position
    else :
      new_path.global_position = paths[paths.size() - 1].global_position - Vector3(0, 0, path_width)
    paths.append(new_path)

func shift_paths(delta: float) -> void:
    for path in paths:
        path.global_position += Vector3(0, 0, delta * speed)
