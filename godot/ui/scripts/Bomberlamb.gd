extends Sprite2D

@export var texture_available: CompressedTexture2D
@export var texture_not_available: CompressedTexture2D

func _process(delta: float) -> void:
	if GameManager.player:
		if GameManager.player.can_i_launch_it(GameManager.kamikaze_cost):
			texture = texture_available
		else:
			texture = texture_not_available
