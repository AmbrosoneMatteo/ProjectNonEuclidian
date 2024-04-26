extends Node

var start 

var music_volume=100.0
var sound_volume=100.0

var game_status: Node3D
var player_position := Vector3(0,0,0)
var tutorial_watched := false
const sassi_disponibili = 20
var numero_sassi := 20
var sassi_posionati := []
var statue_posizionate
var gameover: bool = false

func create_stone(position):
	print("Sasso ->",position, "n sassi -> ", numero_sassi)
	var body = RigidBody3D.new()
	var mesh = BoxMesh.new()
	var particle = MeshInstance3D.new()
	var collision = CollisionShape3D.new()
	collision.scale_object_local(Vector3(0.1, 0.1, 0.1))
	var new_material = StandardMaterial3D.new()
	new_material.albedo_color = Color(1, 0, 0)  # Rosso
	mesh.material = new_material
	mesh.size = Vector3(0.1, 0.1, 0.1)# Modifica le dimensioni lungo gli assi X, Y e Z
	particle.mesh =mesh
	collision.shape = BoxShape3D.new()
	body.add_child(particle)
	body.add_child(collision)
	body.position=position
	start.add_child(body)
