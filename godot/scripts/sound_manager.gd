extends Node


@export var NoPositionSoundPrefab : PackedScene;
@export var FallingSound : AudioStream;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func PlaySound() -> void:
	var srcAudio : AudioStream  = FallingSound
	var soundComp : AudioStreamPlayer = NoPositionSoundPrefab.instantiate()
	soundComp.stream = srcAudio
	soundComp.play()
	var streamLen : float = srcAudio.get_length()
	await get_tree().create_timer(streamLen + 1.0).timeout
	soundComp.queue_free()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass
	
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_pressed():
		PlaySound()
		pass
	pass
