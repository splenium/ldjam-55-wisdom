extends Node2D
var step: int = 1;
var bulle_text_label: RichTextLabel;
var next_button: Button;

var second_text: String = "That's where our true power lies, in the darkness that resides in our hearts, in the madness that fuels our minds.";
var last_text: String = "Together, we shall overturn kingdoms! Let us march together, my little lambs, and fear nothing and no one! Let us bring hell to earth!";

var last_button_text: String = "Let's kick ass !"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioMenuPlayer.play_music_level();
	
	bulle_text_label = get_node("BulleText/RichTextLabel")
	next_button = get_node('Bouton/Button')	
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_on_button_pressed()

func _on_button_pressed() -> void :
	AudioMenuPlayer.play_baiiii_sound();
	step = step + 1;
	if(step == 2) :
		bulle_text_label.text = second_text;
	if (step == 3) :
		bulle_text_label.text = last_text;
		
		next_button.text = last_button_text
	if( step == 4):
		AudioMenuPlayer.stop_menu_level();
		GameManager.next_level();
	pass # Replace with function body.
