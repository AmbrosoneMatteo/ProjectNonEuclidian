extends Node3D

@export var player_entered: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	
#	self.get_child(0).mesh = StandardMaterial3D.new()
	player_entered = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
