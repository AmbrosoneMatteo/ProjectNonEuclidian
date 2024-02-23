extends Node3D

@onready var player := $Player

@onready var player_twist := $Player/TwistPivot
@onready var player_pitch := $Player/TwistPivot/PitchPivot
@onready var viewport_camera := $structure/Control/SubViewport/Camera3D

@onready var c := $structure/MeshInstance3D2
@onready var a := $"structure/platform-1/MeshInstance3D"
@onready var b := $"structure/platform-2/MeshInstance3D"


# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_camera.set_cull_mask(2)
	c.set_layer_mask_value(2,2)
	a.set_layer_mask_value(2,2)
	b.set_layer_mask_value(2,2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player.portal == 0:
		player.desination_position = Vector3(10,20,1)
	else:
		player.desination_position = Vector3(-10,20,-1)
	viewport_camera.position.y = player.position.y + 1
		
	viewport_camera.rotation.x = player_pitch.rotation.x
	viewport_camera.rotation.y = player_twist.rotation.y

