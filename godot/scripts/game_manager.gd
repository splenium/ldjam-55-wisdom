extends Node

var world_speed: float = 1.0 # default 1.0
var player: Player
var soundManager: SoundManager

var kamikaze_cost: int = 1
var mega_sheep_cost: int = 10
var cthulhu_cost: int = 40

var levelIndex := -1
@export var levels: Array[PackedScene] = []
@export var startManu: PackedScene
@export var endGame: PackedScene

var number_of_sheep := 0

func PlaySound(key: String) -> void:
	if soundManager:
		soundManager.PlaySound(key)

func next_level() -> void:
	levelIndex += 1
	if (levelIndex < levels.size()):
		get_tree().change_scene_to_packed(levels[levelIndex])
	else:
		get_tree().change_scene_to_packed(endGame)
		levelIndex = -1

func find_ennemy(parent: Node) -> Ennemy:
	for child in parent.get_children():
		if child is Priest:
			return child
		var grandchild := find_ennemy(child)
		if grandchild != null:
			return grandchild
	return null
