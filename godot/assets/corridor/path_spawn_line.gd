class_name PathSpawnLine extends Path3D

var paths: Array[Node3D] = []

var path_width := 2.55

func _ready() -> void:
    var position_on_line: PathFollow3D = %PositionOnLine
    position_on_line.progress_ratio = 0
    while position_on_line.progress_ratio < 1:
        spawn_path(position_on_line.global_transform)
        position_on_line.progress += path_width

func spawn_path(spawn_transform: Transform3D) -> void:
    var new_path := preload("res://assets/corridor/lower_path_tile.tscn").instantiate()
    add_child(new_path)
    new_path.global_transform = spawn_transform
    paths.append(new_path)
