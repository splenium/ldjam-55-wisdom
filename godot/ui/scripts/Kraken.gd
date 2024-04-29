extends Sprite2D

@export var texture_available: CompressedTexture2D
@export var texture_not_available: CompressedTexture2D

func _process(_delta: float) -> void:
	if GameManager.player:
		if GameManager.player.can_i_launch_it(GameManager.cthulhu_cost):
			texture = texture_available
		else:
			texture = texture_not_available
