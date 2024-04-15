extends Node2D
var sheep_counter : RichTextLabel;

var bomberland_power_label: RichTextLabel;
var sheepnoris_power_label: RichTextLabel;
var kraken_power_label: RichTextLabel;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sheep_counter = get_node("SheepCounterGreenShadow/RichTextLabel");
	sheep_counter.text = "[center]" + "0" + "[/center]";
	
	bomberland_power_label = get_node("Powers/Bomberlamb/SacrificeLabel");
	bomberland_power_label.text = "[center]" + str(GameManager.kamikaze_cost) + "[/center]";
	
	sheepnoris_power_label = get_node("Powers/Sheepnorris/SacrificeLabel");
	sheepnoris_power_label.text = "[center]" + str(GameManager.mega_sheep_cost) + "[/center]";
	
	kraken_power_label = get_node("Powers/Kraken/SacrificeLabel");
	kraken_power_label.text = "[center]" + str(GameManager.cthulhu_cost) + "[/center]";
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d: float) -> void:
	sheep_counter.text = "[center]" + str(GameManager.player.get_only_sacrificial_sheep()) + "[/center]";
	pass
