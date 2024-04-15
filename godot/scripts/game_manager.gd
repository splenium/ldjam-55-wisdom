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
@export var victoryMenu: PackedScene
@export var gameOver: PackedScene
@export var maximum_visisble_sheep: int = 100

var currentLevel: PackedScene

var number_of_sheep := 0

func _ready() -> void:
	pass

func PlaySound(key: String) -> void:
	if soundManager:
		soundManager.PlaySound(key)
var PostFXRect:ColorRect

func next_level() -> void:
	var step: = 1. /30.
	var duration: = 1.
	var curTime: = 0.
	var postFXRectGroup := get_tree().get_nodes_in_group("PostFXRect")
	PostFXRect = postFXRectGroup[0] if postFXRectGroup.size() > 0 else null
	if PostFXRect && is_instance_valid(PostFXRect):
		while true:
			PostFXRect.material.set("shader_parameter/factor", 1 - curTime / duration) 
			curTime += step
			await get_tree().create_timer(step).timeout
			if curTime > duration:
				break
	levelIndex += 1
	if (levelIndex < levels.size()):
		currentLevel = levels[levelIndex]
		get_tree().change_scene_to_packed(levels[levelIndex].duplicate(true))
	else:
		get_tree().change_scene_to_packed(victoryMenu)
		levelIndex = -1

func game_over() -> void:
	get_tree().change_scene_to_packed(gameOver)

func load_start_menu() -> void:
	get_tree().change_scene_to_packed(startManu)	

func reload_level() -> void:
	get_tree().change_scene_to_packed(currentLevel.duplicate(true))

func find_nearest_of_player_ennemy() -> Ennemy:
	var all_enemy: Array[Node] = get_tree().get_nodes_in_group("ennemy")
	var closet_ennemy: Ennemy = null
	var closet_distance: float = -1.0
	if player:
		for enemy in all_enemy:
			var distance_between_player_and_ennemy: float = player.global_position.distance_to(enemy.global_position)
			if closet_distance < 0 or distance_between_player_and_ennemy < closet_distance:
				closet_distance = distance_between_player_and_ennemy
				closet_ennemy = enemy
	return closet_ennemy
