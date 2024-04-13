class_name Player extends CharacterBody3D

@export var speed: float = 4.0
@export var sheepNumber: int = 1
@export var spawnPointSheep: Node3D
@export var spawn_sheep_path: PackedScene
@export var follow_point: Node3D

@export var spawn_x_offset: float = 5.0
@export var spawn_y_offset: float = 5.0
@export var spawn_sheep_line: int = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(spawn_sheep_path != null, "spawn_sheep_path is null on " + self.name)
	assert(spawnPointSheep != null, "spawnPointSheep is null on " + self.name)
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
	
func apply_sheep_modificator(modificator: int) -> void:
	var sheepDifference: int = self.sheepNumber + self.sheepNumber * modificator
	self.sheepNumber += sheepDifference
	if sheepDifference > 0:
		for i in range(0, sheepDifference):
			var instance: Sheep = spawn_sheep_path.instantiate()
			instance.target = follow_point
			var middle_offset: float = ((spawn_sheep_line * spawn_x_offset) / 2)
			instance.position.x = instance.position.x + (i % spawn_sheep_line) * spawn_x_offset - middle_offset
			instance.position.z += 10 + ceil(i / spawn_sheep_line) * spawn_y_offset
			self.spawnPointSheep.add_child(instance)
	pass
