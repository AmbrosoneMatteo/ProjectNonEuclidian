extends AudioStreamPlayer

@onready var volume =  get_node("/root/Global")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
<<<<<<< Updated upstream
	volume = -40.0 + Global.music_volume/2
=======
	if(Global.music_volume==0):
		volume_db = -80
	else:
		volume_db = -30+(Global.music_volume*36/100)


>>>>>>> Stashed changes
