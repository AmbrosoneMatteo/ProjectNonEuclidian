extends Node3D

# PORTAL


@onready var a := $"Area3D"
@export var area = false
@export var viewport = false
@export var enabled = true
@export var exit_position = false
@export var destination_portal = false
@export var checkpoint_enabled = false
@export var connection: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	area = a


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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


