class_name PathGenerator extends Node3D

@export var spawn_z := -40.0
@export var despawn_z := 15.0
var first_spawn_position := Vector3(0, 0, despawn_z)
@export var path_width := 10.0

@export var level_tiles: Array[PackedScene] = []
@export var displayed_paths: Array[Node3D] = []

func _ready() -> void:
	var last_path: Node3D = null
	while ((last_path == null || last_path.global_position.z > spawn_z) && level_tiles.size() > 0):
		spawn_path()
		last_path = displayed_paths[displayed_paths.size() - 1]

func _process(delta: float) -> void:
	shift_paths(delta)
	var last_path := displayed_paths[displayed_paths.size() - 1]
	if last_path.global_position.z > spawn_z:
		spawn_path()
	if displayed_paths.size() > 1 and displayed_paths[0].global_position.z > despawn_z:
		displayed_paths[0].queue_free()
		displayed_paths.pop_front()

func spawn_path() -> void:
	if level_tiles.size() == 0:
		return
	var new_path: Node3D = level_tiles.pop_front().instantiate()
	add_child(new_path)
	if displayed_paths.size() == 0:
		new_path.global_position = first_spawn_position
	else :
		new_path.global_position = displayed_paths[displayed_paths.size() - 1].global_position - Vector3(0, 0, path_width)
	displayed_paths.append(new_path)

func shift_paths(delta: float) -> void:
	for path in displayed_paths:
		path.global_position += Vector3(0, 0, delta * GameManager.world_speed)
