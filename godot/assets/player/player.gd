class_name Player extends CharacterBody3D

@export var speed: float = 0.75 # default 0.75
@export var spawnPointSheep: Node3D
@export var spawn_sheep_path: PackedScene

@export var follow_point: Node3D

@export var spawn_x_offset: float = 0.5
@export var spawn_y_offset: float = 0.5
@export var spawn_sheep_line: int = 3

@export var follow_step_size: float = 0.025
@export var follow_sheep_number_per_step: int = 20

@export var PortalParticle: CPUParticles3D 
@export var sheep_kamikaze: PackedScene

@export var cthulhu_scene: PackedScene

@export var mega_sheep: PackedScene
@export var mega_sheep_spawn_z_offset := 1

var sheepList: Array[Sheep] = []
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(spawn_sheep_path != null, "spawn_sheep_path is null on " + self.name)
	assert(sheep_kamikaze != null, "sheep_kamikaze is null on " + self.name)
	assert(sheep_kamikaze != null, "sheep_kamikaze is null on " + self.name)
	assert(spawnPointSheep != null, "spawnPointSheep is null on " + self.name)
	GameManager.player = self
	apply_sheep_edition(GameManager.number_of_sheep)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_d: float) -> void:
	GameManager.number_of_sheep = get_only_sacrificial_sheep()
	attack()
	pass

func _physics_process(delta: float) -> void:
	move(delta)
	pass

func move(d: float) -> void:
	var direction: Vector3 = Vector3(0,0,0)
	if Input.is_action_pressed("ui_left"):
		direction = Vector3(-speed * d, 0, 0)
	if Input.is_action_pressed("ui_right"):
		direction = Vector3(+speed * d, 0, 0)
	if not is_on_floor():
		direction.y -= gravity * d
	move_and_collide(direction) # do it better
	move_and_slide()
	pass

func attack() -> void:
	if Input.is_action_just_pressed("attack_cthulhu"):
		summon_cthulhu()
	if Input.is_action_just_pressed("attack_kamikaze"):
		summon_kamikaze()
	if Input.is_action_just_pressed("attack_mega_sheep"):
		summon_mega_sheep()
	pass
	
func can_i_launch_it(cost: int) -> bool:
	return get_only_sacrificial_sheep() > cost

func summon_cthulhu() -> void:
	if !can_i_launch_it(GameManager.cthulhu_cost):
		GameManager.PlaySound("Bai")
		return
	apply_sheep_addition(-GameManager.cthulhu_cost)
	var cthulhu: Cthulhu = cthulhu_scene.instantiate()
	get_parent().add_child(cthulhu)

func summon_kamikaze() -> void:
	if can_i_launch_it(GameManager.kamikaze_cost):
		GameManager.PlaySound("Rocket")
		var futurKamikaze: Sheep = get_random_sacrifiable_sheep()
		apply_sheep_addition(-(GameManager.kamikaze_cost - 1))
		var kamikaze: KamikazeSheep = sheep_kamikaze.instantiate()
		get_parent().add_child(kamikaze)
		kamikaze.global_position = futurKamikaze.global_position
		remove_sheep(futurKamikaze)
		kamikaze.target = GameManager.find_ennemy(get_parent())
	else:
		GameManager.PlaySound("Bai")
	
func summon_mega_sheep() -> void:
	if can_i_launch_it(GameManager.mega_sheep_cost):
		apply_sheep_addition(-GameManager.mega_sheep_cost)
		var mega_sheep_instance: MegaSheep = mega_sheep.instantiate()
		spawnPointSheep.add_child(mega_sheep_instance)
		mega_sheep_instance.global_position.z += mega_sheep_spawn_z_offset
	else:
		GameManager.PlaySound("Bai")

func update_follow_point() -> void:
	@warning_ignore("integer_division")
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
	PortalParticle.restart()
	PortalParticle.emitting = true
	var sheepDiff: int = sheep_to_add
	apply_sheep_edition(sheepDiff)
	pass

func apply_sheep_multiplicator(multiplicator: int) -> void:
	PortalParticle.restart()
	PortalParticle.emitting = true
	var sheepDiff := 0
	if multiplicator < 0:
		@warning_ignore("integer_division")
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
			@warning_ignore("integer_division")
			sheep.position.z += ceil(i / spawn_sheep_line) * spawn_y_offset
			add_sheep(sheep)
	elif sheepDiff < 0:
		var numsToDelete: int = abs(sheepDiff)
		if(numsToDelete >= get_only_sacrificial_sheep()):
			remove_all_sheep()
		else:
			for i in range(0, numsToDelete):
				remove_sheep(sheepList[0])
	update_follow_point()
	pass

func remove_sheep(sheep: Sheep) -> void:
	var idx: int = sheepList.find(sheep)
	if idx != -1:
		sheepList.remove_at(idx)
		sheep.die()
		update_follow_point()
	pass

func remove_all_sheep() -> void:
	for sheep in sheepList:
		sheep.queue_free()
	sheepList.clear()
	pass
	
func get_random_sacrifiable_sheep() -> Sheep:
	return sheepList.pick_random()
