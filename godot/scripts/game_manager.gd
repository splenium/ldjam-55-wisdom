extends Node

var world_speed := 1.0
var player: Player
var soundManager: SoundManager

func PlaySound(key: String) -> void:
	if soundManager:
		soundManager.PlaySound(key)
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func find_ennemy(parent: Node) -> Ennemy:
	for child in parent.get_children():
		if child is Priest:
			return child
		var grandchild := find_ennemy(child)
		if grandchild != null:
			return grandchild
	return null
