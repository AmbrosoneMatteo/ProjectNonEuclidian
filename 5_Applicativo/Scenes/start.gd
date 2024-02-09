extends Node3D

@onready var player := $Player
@onready var player_twist := $Player/TwistPivot
@onready var player_pitch := $Player/TwistPivot/PitchPivot
@onready var viewport_camera := $structure/Control/SubViewport/Camera3D

@onready var c := $structure/MeshInstance3D2
@onready var a := $"structure/platform-1/MeshInstance3D"
@onready var b := $"structure/platform-2/MeshInstance3D"
@onready var wall_1 := $"structure/wall-1/MeshInstance3D"
#@onready var wall_2 := $"structure/Control/SubViewport"


var portal := 0 # Portale attivo
var portals := [] # Lista dei portali presenti in game

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_camera.set_cull_mask(2)
	c.set_layer_mask_value(2,2)
	a.set_layer_mask_value(2,2)
	b.set_layer_mask_value(2,2)
	wall_1.set_layer_mask_value(2,2)
	set_portals()
	
	portals[0].viewport = $"structure/Control2/SubViewport"
	portals[0].get_node("Sprite3D").set_texture(portals[0].viewport.get_texture())
	portals[0].destination_portal = portals[1]
	
	portals[1].viewport = $"structure/Control/SubViewport"
	portals[1].get_node("Sprite3D").set_texture(portals[1].viewport.get_texture())
	portals[1].destination_portal = portals[0]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	viewport_camera.position.y = player.position.y + 1.5
	if abs(get_delta_x())<2:
		viewport_camera.position.x = portals[0].position.x - get_delta_x()
	if player.position.z > -4 and player.position.z <-2.5:
		viewport_camera.position.z = portals[0].position.z - get_delta_z() * 1.1
		
	viewport_camera.rotation.y = player_twist.rotation.y
	
	near_portal()

func near_portal():
	for i in range(len(portals)):
		if is_near(portals[i].position,3):
			reset_portals()
			portals[i].checkpoint_enabled = true
			player.desination_position = portals[i].destination_portal.position + Vector3(0,0,1)

# [Portali]
# Disattiva i checkpoint di tutti i portali (li setta su false)
func reset_portals():
	for i in range(len(portals)):
		portals[i].checkpoint_enabled = false

func set_portals():
	portals.append($"structure/portal-1")
	portals.append($"structure/portal-2")
	
# Ritorna true se la distanza tra i 2 vettori è minore di max_distance 
func is_near(pos,max_distance):
	var distance = calculate_distance(pos,player.position) # Viene calcolata la distranza tra i vettori
	if distance < max_distance:
		return true
	return false
	
func calculate_distance(vector1: Vector3, vector2: Vector3) -> float:
	return vector1.distance_to(vector2)

func get_delta_x(pos = portals[1].position):
	return pos.x - player.position.x

func get_delta_z(pos = portals[1].position):
	return pos.z - player.position.z
	

