extends RayCast3D

var last_body
var red_material = StandardMaterial3D.new()
var blue_material = StandardMaterial3D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	red_material.albedo_color = Color(1, 0, 0) # Rosso
	blue_material.albedo_color = Color(0, 0, 1)  # Blu
#	add_exception(owner)

#func _input(event: InputEvent):
#	pass
	
func _input(ev):
	if not last_body == null:
		if not is_colliding():
			last_body.mesh.material = red_material
		elif not last_body == get_collider().get_child(0):
			last_body.mesh.material = red_material
#
	if is_colliding():
		# Raccolta Statua
		if get_collider().name.contains("Body"):
			if get_collider().get_parent().get_parent().name.contains("statua"):
				set_message_visibility(true)
				pickup_statua(get_collider().get_parent().get_parent().get_parent())
			else:
				set_message_visibility(false)
#
		# Raccolta Sasso
		if get_collider().name.contains("sasso"):
			set_message_visibility(true)
			pickup_stone(get_collider())
			last_body = get_collider().get_child(0)
		elif not get_collider().name.contains("Body"):
			set_message_visibility(false)
	else:
		set_message_visibility(false)

func set_message_visibility(status):
	Global.start.get_node("Player/TwistPivot/PitchPivot/Camera3D/CanvasLayer/Control2/PickupMessagePanel").visible = status

func pickup_stone(body):
	body.get_child(0).mesh.material = blue_material
	if Input.is_action_just_pressed("pickup"):
		Global.start.remove_child(body)
		Global.stones_number = Global.stones_number + 1
		for i in range(len(Global.stones_placed)):
			if(body.name=="sasso"+str(i)):
				Global.stones_placed.pop_at(i)

func pickup_statua(body):
	if Input.is_action_just_pressed("pickup"):
		Global.start.remove_child(body)
		var statue = body.get_child(0).name.split("statua-")
		for value in statue:
			if len(value)>0:
				Global.collected_statues.append(value)
