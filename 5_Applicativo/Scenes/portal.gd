extends Node3D

# PORTAL

<<<<<<< HEAD
@onready var a := $"Area3D"

@export var area = false
@export var viewport = false
@export var enabled = true
=======
@export var viewport = false
>>>>>>> c832fe9d0629cb088f35aef510a9b4461c34e881
@export var exit_position = false
@export var destination_portal = false
@export var checkpoint_enabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
<<<<<<< HEAD
	area = a
=======
	pass # Replace with function body.

>>>>>>> c832fe9d0629cb088f35aef510a9b4461c34e881

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
<<<<<<< HEAD

func print_collsions(numb):
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		print("Portal ",numb," ",body)
	

func cross():
	if len(area.get_overlapping_bodies()) > 0:
		destination_portal.enabled = false
	
func crossed():
	if len(area.get_overlapping_bodies()) == 0:
		pass
	enabled = true
#	destination_portal.enabled = true

#func set_exit_position(player_position):
#	if position.z > player_position:
#		exit_position = position + Vector3(0,-1,0)
#	else:
#		exit_position = position - Vector3(0,1,0)

=======
>>>>>>> c832fe9d0629cb088f35aef510a9b4461c34e881
