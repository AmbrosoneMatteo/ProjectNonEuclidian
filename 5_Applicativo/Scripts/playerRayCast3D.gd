extends RayCast3D

var last_body
var red_material = StandardMaterial3D.new()
var blue_material = StandardMaterial3D.new()

# Called when the node enters the scene tree for the first time.
#func _ready():
#	add_exception(owner)

func _input(event: InputEvent):
	pass
	
func _physics_process(delta):
	if not last_body == null:
		if not is_colliding():
			red_material.albedo_color = Color(1, 0, 0)  # Rosso
			last_body.mesh.material = red_material
		elif not last_body == get_collider().get_child(0):
			red_material.albedo_color = Color(1, 0, 0)  # Rosso
			last_body.mesh.material = red_material
	
	if is_colliding():
		
#		if get_collider().name.contains("tatua"):
		print(get_collider().name,": ",get_collision_point())
			
#			blue_material.albedo_color = Color(0, 0, 1)  # Blu
#			get_collider().get_child(0).mesh.material = blue_material
		
		if get_collider().name.contains("sasso"):
			print(get_collider().name,": ",get_collision_point())
			
			blue_material.albedo_color = Color(0, 0, 1)  # Blu
			get_collider().get_child(0).mesh.material = blue_material
			
			if Input.is_action_just_pressed("pickup"):
				Global.start.remove_child(get_collider())
				Global.stones_number = Global.stones_number + 1
				for i in range(len(Global.sassi_posionati)):
					if(get_collider().name=="sasso"+str(i)):
						Global.sassi_posionati.pop_at(i)
			last_body = get_collider().get_child(0)
