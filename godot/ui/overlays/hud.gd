extends Node2D
var sheep_counter : RichTextLabel;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sheep_counter = get_node("SheepCounterGreenShadow/RichTextLabel");
	sheep_counter.text = "[center]" + "0" + "[/center]";
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d: float) -> void:
	sheep_counter.text = "[center]" + str(GameManager.player.get_only_sacrificial_sheep()) + "[/center]";
	pass
