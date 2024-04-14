class_name Player extends CharacterBody3D

@export var speed: float = 0.75
@export var spawnPointSheep: Node3D
@export var spawn_sheep_path: PackedScene
@export var follow_point: Node3D

@export var spawn_x_offset: float = 0.5
@export var spawn_y_offset: float = 0.5
@export var spawn_sheep_line: int = 3.0

@export var follow_step_size: float = 0.025
@export var follow_sheep_number_per_step: int = 20

var sheepList: Array[Sheep] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(spawn_sheep_path != null, "spawn_sheep_path is null on " + self.name)
	assert(spawnPointSheep != null, "spawnPointSheep is null on " + self.name)
	GameManager.player = self
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
	
func update_follow_point() -> void:
	follow_point.position.z = -floor(get_sheep_number() / follow_sheep_number_per_step) * follow_step_size - 0.55
	pass
	
func instantiate_sheep() -> Sheep:
	var instance: Sheep = spawn_sheep_path.instantiate()
	instance.target = follow_point
	return instance
	
func add_sheep(sheep: Sheep) -> void:
	spawnPointSheep.add_child(sheep)
	sheepList.append(sheep)
	pass
	
func get_sheep_number() -> int:
	# Take in account the player
	return sheepList.size() + 1

func get_only_sacrificial_sheep() -> int:
	return sheepList.size()
	
func apply_sheep_addition(sheep_to_add: int) -> void:
	var sheepDiff: int = sheep_to_add
	apply_sheep_edition(sheepDiff)
	pass
	
func apply_sheep_multiplicator(multiplicator: int) -> void:
	var sheepDiff := 0
	if multiplicator < 0:
		sheepDiff = get_only_sacrificial_sheep() / multiplicator		
	else:
		sheepDiff = get_only_sacrificial_sheep() * multiplicator
	apply_sheep_edition(sheepDiff)
	pass
	
func apply_sheep_edition(sheepDiff: int) -> void:
	if sheepDiff > 0:
		for i in range(0, sheepDiff):
			var sheep: Sheep = instantiate_sheep()
			var middle_offset: float = ((spawn_sheep_line * spawn_x_offset) / 2)
			sheep.position.x = sheep.position.x + (i % spawn_sheep_line) * spawn_x_offset - middle_offset
			sheep.position.z += ceil(i / spawn_sheep_line) * spawn_y_offset
			add_sheep(sheep)
	elif sheepDiff < 0:
		var numsToDelete: int = abs(sheepDiff)
		if(abs(sheepDiff) >= get_only_sacrificial_sheep()):
			remove_all_sheep()
		else:
			for i in range(0, abs(sheepDiff)):
				remove_sheep(sheepList[0])
	update_follow_point()
	pass

func remove_sheep(sheep: Sheep) -> void:
	var idx: int = sheepList.find(sheep)
	if idx != -1:
		sheepList.remove_at(idx)
		sheep.queue_free()
		update_follow_point()
	pass

func remove_all_sheep() -> void:
	for sheep in sheepList:
		sheep.queue_free()
	sheepList.clear()
	pass
