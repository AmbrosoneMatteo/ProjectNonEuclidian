extends Control

@onready var volume_vars = get_node("/root/Global")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var count_delta=0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count_delta+=delta
	if count_delta<1.0:
		$volume_music.value=Global.music_volume
		$volume_audio.value=Global.sound_volume
	Global.music_volume=$volume_music.value
	Global.sound_volume=$volume_audio.value

