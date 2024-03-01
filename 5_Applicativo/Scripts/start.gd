extends Node3D

@onready var player := $Player
@onready var player_twist := $Player/TwistPivot
@onready var player_pitch := $Player/TwistPivot/PitchPivot
@onready var viewport_camera := $structure/Control/SubViewport/Camera3D


@onready var a := $structure/MeshInstance3D2
@onready var b := $structure/MeshInstance3D
@onready var c := $"structure/platform-1/MeshInstance3D"
@onready var d := $"structure/platform-2/MeshInstance3D"
@onready var wall_1 := $"structure/wall-1/MeshInstance3D"
@onready var wall_2 := $"structure/wall-2/MeshInstance3D"
@onready var wall_3 := $"structure/wall-3/MeshInstance3D"
@onready var wall_4 := $"structure/wall-4/MeshInstance3D"


@onready var portal := $"structure/portal-1" # Portale attivo
var portals := [] # Lista dei portali presenti in game


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused=false
	viewport_camera.set_cull_mask(2)
	c.set_layer_mask_value(2,2)
	a.set_layer_mask_value(2,2)
	b.set_layer_mask_value(2,2)
	d.set_layer_mask_value(2,2)
	wall_1.set_layer_mask_value(2,2)
	wall_2.set_layer_mask_value(2,2)
	wall_3.set_layer_mask_value(2,2)
	wall_4.set_layer_mask_value(2,2)
	set_portals()
	
	viewport_camera.position.y = player.position.y + 1


#func _process(delta):
#	viewport_camera.position.y = player.position.y + 1.5
#	if abs(get_delta_x())<2:
#		viewport_camera.position.x = portals[0].position.x - get_delta_x()
#	if player.position.z > -4 and player.position.z <-2.5:
#		viewport_camera.position.z = portals[0].position.z - get_delta_z() * 1.1
#
#	viewport_camera.rotation.y = player_twist.rotation.y
#
#	near_portal()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	portals[0].print_collsions(0)
#	portals[1].print_collsions(1)
#	portals[2].print_collsions(2)
#	portals[3].print_collsions(3)
	
	
	
	if abs(get_delta("x"))<2:
		#viewport_camera.position.x = portals[0].position.x - get_delta("x")
		viewport_camera.position.x = portal.destination_portal.position.x - get_delta("x")
	if player.position.z > -4 and player.position.z <-2.5:
		#viewport_camera.position.z = portals[0].position.z - get_delta("z") * 1.1
		#viewport_camera.position.z = portal.destination_portal.position.z - get_delta("z") * 1.1
		pass
		
	viewport_camera.rotation.y = player_twist.rotation.y
	
	if len(portal.destination_portal.area.get_overlapping_bodies()) > 0:
		portal.cross()
		portal.enabled = false
		print(portal.enabled)
		
	near_portal()
	
	if not portal.enabled and len(portal.destination_portal.area.get_overlapping_bodies()) == 0:
		portal.crossed()
		print("crossed")
#		print("Portal 1 ",portal.is_enabled)
#		print("Portal 2 ",portal.destination_portal.is_enabled)
	
	
	

# Verifica quale sia il portale più vicino
# e lo imposta come portale attivo.
func near_portal():
	for i in range(len(portals)):
		if is_near(portals[i].position,3):
			if not portal.enabled:
				print("yep  ",portal.destination_portal.position)
			else:
				#print("nop  ",portal.destination_portal.position)
				player.desination_position = portal.destination_portal.position
				portal = portals[i]
				reset_portals()
				portal.checkpoint_enabled = true
#				portal.destination_portal.set_exit_position(player.position.z)
				
#				player.desination_position = portal.destination_portal.exit_position

#func near_portal():
#	for i in range(len(portals)):
#		if is_near(portals[i].position,3):
#			reset_portals()
#			portals[i].checkpoint_enabled = true
#			player.desination_position = portals[i].destination_portal.position + Vector3(0,0,1)			

	wall_1.set_layer_mask_value(2,2)
	set_portals()
	
	portals[0].viewport = $"structure/Control2/SubViewport"
	portals[0].get_node("Sprite3D").set_texture(portals[0].viewport.get_texture())
	portals[0].destination_portal = portals[1]
	
	portals[1].viewport = $"structure/Control/SubViewport"
	portals[1].get_node("Sprite3D").set_texture(portals[1].viewport.get_texture())
	portals[1].destination_portal = portals[0]
	pass # Replace with function body.






# Ritorna true se la distanza tra i 2 vettori è minore di max_distance 
func is_near(pos,max_distance):
	var distance = calculate_distance(pos,player.position) # Viene calcolata la distranza tra i vettori
	if distance < max_distance:
		return true
	return false

# [Portali]
# Disattiva i checkpoint di tutti i portali (li setta su false)
func reset_portals():
	for i in range(len(portals)):
		portals[i].checkpoint_enabled = false


	
	

func get_delta(axis = "x"):
	match axis:
		"x":
			return portal.position.x - player.position.x
		"y":
			return portal.position.z - player.position.z
		"z":
			return portal.position.z - player.position.z

func set_portals():
	portals.append($"structure/portal-1")
	portals.append($"structure/portal-2")
	portals.append($"structure/portal-3")
	portals.append($"structure/portal-4")
	
	portals[0].viewport = $"structure/Control/SubViewport"
	portals[0].get_node("Sprite3D").set_texture(portals[0].viewport.get_texture())
	portals[0].destination_portal = portals[1]
	
	portals[1].viewport = $"structure/Control/SubViewport"
	portals[1].get_node("Sprite3D").set_texture(portals[1].viewport.get_texture())
	portals[1].destination_portal = portals[0]
	
	portals[2].viewport = $"structure/Control/SubViewport"
	portals[2].get_node("Sprite3D").set_texture(portals[2].viewport.get_texture())
	portals[2].destination_portal = portals[3]
	
	portals[3].viewport = $"structure/Control/SubViewport"
	portals[3].get_node("Sprite3D").set_texture(portals[3].viewport.get_texture())
	portals[3].destination_portal = portals[2]
	
	portal = portals[1]

func calculate_distance(vector1: Vector3, vector2: Vector3) -> float:
	return vector1.distance_to(vector2)

func get_delta_x(pos = portals[1].position):
	return pos.x - player.position.x

func get_delta_z(pos = portals[1].position):
	return pos.z - player.position.z
	

