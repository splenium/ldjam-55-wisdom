class_name KamikazeDetectorArea extends Area3D

var instance: KamikazeSheep

func _ready() -> void:
	instance = get_parent()
	assert(instance is KamikazeSheep, name + " must be a direct child of KamikazeSheep, actually child of: " + instance.name)
	
func explode(ennemy: Ennemy) -> void:
	instance.explode(ennemy)
