extends Node3D

@onready var player := $Player
@onready var player_twist := $Player/TwistPivot
@onready var player_pitch := $Player/TwistPivot/PitchPivot

@onready var Portals = $portals
@onready var Teleports = $"teleports"

var teleports = []
var portals := [] # Lista dei portali presenti in game


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.numero_sassi = Global.sassi_disponibili
	Global.start = self
	Global.gameover = false
	for stone in Global.sassi_posionati:
		Global.create_stone(stone)
#	if Global.player_position!=Vector3(0,0,0):
#		player.position=Global.player_position
	for stone in Global.stones_placed:
		Global.create_stone(stone)
	for statue in Global.collected_statues:
		remove_child(get_node("Statua/statua-"+statue).get_parent())
	if Global.player_position!=Vector3(0,0,0):
		player.position=Global.player_position
	get_tree().paused=false
	set_portals()
	
#	viewport_camera.position.y = player.position.y + 1


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
	for i in portals:
		var twist_pivot = i.get_node("Control/SubViewport/TwistPivot")
		var pitch_pivot = twist_pivot.get_node("PitchPivot")
		twist_pivot.global_position = portals[i.connection].global_position+(player.global_position-i.global_position)
		twist_pivot.look_at(i.global_position)
		twist_pivot.global_rotation = player.get_node("TwistPivot").global_rotation
		pitch_pivot.global_rotation = player.get_node("TwistPivot/PitchPivot").global_rotation
#to delete later		camera.global_rotation.y = acos((PlayerToPortal).dot(PointToPortal)/(norm(PlayerToPortal)*norm(PointToPortal)))+portal.global_rotation.y
		#camera.global_rotation_degrees.x = (vectors_x[1]-vectors_x[2]).dot(vectors_x[0]-vectors_x[2])
#
#	if abs(get_delta("x"))<2:
#		#viewport_camera.position.x = portals[0].position.x - get_delta("x")
#		viewport_camera.position.x = portal.destination_portal.position.x - get_delta("x")
#	if player.position.z > -4 and player.position.z <-2.5:
#		#viewport_camera.position.z = portals[0].position.z - get_delta("z") * 1.1
#		#viewport_camera.position.z = portal.destination_portal.position.z - get_delta("z") * 1.1
#		pass
		
#	viewport_camera.rotation.y = player_twist.rotation.y
	
#	if len(portal.destination_portal.area.get_overlapping_bodies()) > 0:
#		portal.cross()
#		portal.enabled = false
#
#	if not portal.enabled and len(portal.destination_portal.area.get_overlapping_bodies()) == 0:
#		portal.crossed()
	
	
	


#func near_portal():
#	for i in range(len(portals)):
#		if is_near(portals[i].position,3):
#			reset_portals()
#			portals[i].checkpoint_enabled = true
#			player.desination_position = portals[i].destination_portal.position + Vector3(0,0,1)			

#	wall_1.set_layer_mask_value(2,2)
#	portals[0].viewport = $"structure/Control2/SubViewport"
#	portals[0].get_node("Sprite3D").set_texture(portals[0].viewport.get_texture())
#	portals[0].destination_portal = portals[1]
#
#	portals[1].viewport = $"structure/Control/SubViewport"
#	portals[1].get_node("Sprite3D").set_texture(portals[1].viewport.get_texture())
#	portals[1].destination_portal = portals[0]



# Ritorna true se la distanza tra i 2 vettori è minore di max_distance 
func is_near(pos,max_distance):
	var distance = calculate_distance(pos,player.position) # Viene calcolata la distranza tra i vettori
	if distance < max_distance:
		return true
	return false

func create_stone(position):
	var new_material = StandardMaterial3D.new()
	new_material.albedo_color = Color(1, 0, 0)  # Rosso
	
	var mesh = MeshInstance3D.new()
	mesh.material_override = new_material
	mesh.position = Vector3(position)
	mesh.mesh = BoxMesh.new()
	add_child(mesh)

#
#func get_delta(axis = "x"):
#	match axis:
#		"x":
#			return portal.position.x - player.position.x
#		"y":
#			return portal.position.z - player.position.z
#		"z":
#			return portal.position.z - player.position.z

func set_portals():
	var taken_portals = []
	for i in Portals.get_children():
		portals.append(i)
	for i in Teleports.get_children():
		teleports.append(i)
	for i in range(len(portals)):
		var portal = portals[i]
		if portals[i].connection == -1:
			var x = randi()%len(portals)-1
			while x==i:
				x = randi()%len(portals)-1
			portals[i].get_node("Sprite3D").set_texture(portal.get_node("Control/SubViewport").get_texture())
			portals[i].connection = x
			taken_portals.append(i)
		portal.get_node("Sprite3D").set_texture(portal.get_node("Control/SubViewport").get_texture())

func calculate_distance(vector1: Vector3, vector2: Vector3) -> float:
	return vector1.distance_to(vector2)

func get_delta_x(pos = portals[1].position):
	return pos.x - player.position.x

func get_delta_z(pos = portals[1].position):
	return pos.z - player.position.z


func on_teleport_player_entered(body,id: int, rotation: int,position: bool, rotate_back: bool =false):
	print("player entered ", len(teleports))
	var player_roation = player.get_node("TwistPivot/PitchPivot/Camera3D").global_rotation.y
	if len(teleports)>id:
		if id == 3:
			player.bonus=30
		if position: #ask if the teleportation needs to subtract the difference between the player and the teleport vector
			player.position.y = teleports[id].position.y-(teleports[id-1].position.y-player.position.y)
			if(teleports[id-1].global_rotation != teleports[id-1].global_rotation):
				player.position.z = teleports[id].position.z+(teleports[id-1].position.x-player.position.x)
				player.position.x = teleports[id].position.x+(teleports[id-1].position.z-player.position.z)
			else:
				player.position.z = teleports[id].position.z - (teleports[id-1].position.z - player.position.z)
				player.position.x = teleports[id].position.x - (teleports[id-1].position.x - player.position.x) 
			print("teleported")
		else:
			# Imposta la posizione del giocatore alla posizione del teletrasporto
			player.position = teleports[id].position
			print("nevermind")
		print("player entered")
		player.gravity*=-1
		player.gravitation*=-1
		if rotate_back:
			player.get_node("TwistPivot/").global_rotation.z -=deg_to_rad(180)
			player.get_node("TwistPivot/").global_rotation.y -=deg_to_rad(180)
		teleports[id].enabled = false
		
		# Stampa un messaggio di conferma del teletrasporto del giocatore


func _input(ev):
	if not ev is InputEventMouse:
		for j in InputMap.action_get_events("pickup"):
			if ev.keycode == j.keycode:
				var statue = $statues
				for i in statue.get_children():
					if i.player_entered:
						i.queue_free()
						Global.statue_posizionate.append(i.name)
		


func _on_statue_touched(body, id:int):
		var path = "Statua/statua-"+str(id) 
		var statua = get_node(path)
		statua.player_entered = true


func _on_statue_not_touched(body, id:int):
	var path = "Statua/statua-"+str(id) 
	var statua = get_node(path)
	statua.player_entered = false
	
func _on_portal_body_entered(body, portal_calling: int):
	var portal = portals[portal_calling]
	if(portal.enabled):
		portals[portal.connection].enabled = false
		if portals[portal.connection].global_rotation.z != portal.global_rotation.z:
			player.gravity*=-1
			player.gravitation*=-1
			player.get_node("TwistPivot/").global_rotation.z -=deg_to_rad(180)
			player.get_node("TwistPivot/").global_rotation.y -=deg_to_rad(180)
		player.get_node("TwistPivot").global_rotation_degrees.y +=  deg_to_rad(abs(portal.global_rotation.y-portals[portal.connection].global_rotation.y))
		portal.enabled = false
		player.position = portals[portal.connection].position

func _on_portal_body_exited(body, id:int):
	portals[id].enabled = true



func _on_limit_jump_sinal_body_entered(body):
	player.JUMP_VELOCITY=6.0


func _on_limit_jump_sinal_body_exited(body):
	player.JUMP_VELOCITY=10.0
