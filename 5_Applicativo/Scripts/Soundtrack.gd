extends AudioStreamPlayer

@onready var volume =  get_node("/root/Global")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Global.music_volume==0):
		volume_db = -100
	else:
		volume_db = -50+(Global.music_volume*36/100)


