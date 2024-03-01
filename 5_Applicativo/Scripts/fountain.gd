extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_particles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_particles():
	var body = RigidBody3D.new()
	var particle = MeshInstance3D.new()
	particle.mesh =BoxMesh.new();
	body.add_child(particle)
	body.position=position
	while true:
		body.set_axis_velocity(Vector3(0,0,0))
		add_child(body)
		await get_tree().create_timer(1.0).timeout
		remove_child(body)
