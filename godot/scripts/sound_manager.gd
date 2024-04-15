class_name SoundManager extends Node

@export var NoPositionSoundPrefab : PackedScene;

@export var BombSound : AudioStream;
@export var RocketSound : AudioStream;
@export var HolySound : AudioStream;
@export var TeleportSound : AudioStream;
@export var BaiSound : AudioStream;
@export var FallingSound : AudioStream;
@export var DieSound : AudioStream;
@export var BraamSound : AudioStream;
@export var HitSound : AudioStream;
@export var RiserSound : AudioStream;
@export var RiserSpeedySound : AudioStream;
@export var PortalSound : AudioStream;
@export var TentaclesSound : AudioStream;
@export var BoomWalk : AudioStream;

@onready var soundsMap : Dictionary = {
	"Bomb": BombSound,
	"Rocket": RocketSound,
	"Holy": HolySound,
	"Teleport": TeleportSound,
	"Bai": BaiSound,
	"Falling": FallingSound,
	"Die": DieSound,
	"Braam": BraamSound,
	"Hit": HitSound,
	"Riser": RiserSound,
	"RiserSpeedy": RiserSpeedySound,
	"PassPortal": PortalSound,
	"Tentacles": TentaclesSound,
	"BoomWalk": BoomWalk,
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.soundManager = self
	pass # Replace with function body.

func PlaySound(key: String) -> void:
	if not soundsMap.has(key):
		printerr("Key not found " + key)
		return
	var srcAudio : AudioStream  = soundsMap.get(key)
	var soundComp : AudioStreamPlayer = NoPositionSoundPrefab.instantiate()
	add_child(soundComp)
	soundComp.stream = srcAudio
	soundComp.play()
	var streamLen : float = srcAudio.get_length()
	await get_tree().create_timer(streamLen + 1.0).timeout
	soundComp.queue_free()
	pass
