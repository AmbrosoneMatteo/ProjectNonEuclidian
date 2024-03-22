extends Control

@onready var volume_vars = get_node("/root/Global")
# Called when the node enters the scene tree for the first time.
func _ready():
	$volume_music.value=Global.music_volume
	$volume_audio.value=Global.sound_volume


var count_delta=0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.music_volume=$volume_music.value
	Global.sound_volume=$volume_audio.value
	print("music: ",Global.music_volume)

