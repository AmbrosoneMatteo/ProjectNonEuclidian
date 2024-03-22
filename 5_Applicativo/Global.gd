extends Node


var music_volume=50.0
var sound_volume=50.0

var game_status: Node3D
var player_position := Vector3(-30,-52,-343)
var tutoria_watched := false

# Player scores
var numero_sassi := 20
var sassi_posionati := []

func create_stone(position):
	var new_material = StandardMaterial3D.new()
	new_material.albedo_color = Color(1, 0, 0)  # Rosso
	
	var mesh = MeshInstance3D.new()
	mesh.material_override = new_material
	mesh.position = Vector3(position)
	mesh.mesh = BoxMesh.new()
	add_child(mesh)
