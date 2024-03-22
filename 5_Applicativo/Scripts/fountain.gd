extends StaticBody3D


var part_material = preload("res://Assets/Materials/emission.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	generate_particles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_particles():
	while true:
		var body = RigidBody3D.new()
		var mesh = BoxMesh.new()
		var particle = MeshInstance3D.new()
		var collision = CollisionShape3D.new()
		mesh.material = part_material
		particle.mesh =mesh
		collision.shape = BoxShape3D.new()
		body.add_child(particle)
		body.add_child(collision)
		body.position=position
		add_child(body)
		await get_tree().create_timer(0.02).timeout

