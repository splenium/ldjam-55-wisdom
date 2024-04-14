extends Node

var world_speed := 1.0
var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func find_ennemy(parent: Node) -> Ennemy:
	for child in parent.get_children():
		if child is Ennemy:
			return child
		var grandchild := find_ennemy(child)
		if grandchild != null:
			return grandchild
	return null
