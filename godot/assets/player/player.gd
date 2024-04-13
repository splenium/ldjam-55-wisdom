class_name Player extends CharacterBody3D

@export var speed: float = 15.0
@export var sheepNumber: int = 1
@export var spawnPointSheep: Node3D
@export var spawn_sheep_path: PackedScene

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
			instance.target = self
			self.spawnPointSheep.add_child(spawn_sheep_path.instantiate())
	pass
