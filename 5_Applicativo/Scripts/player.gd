extends CharacterBody3D



const SPEED = 5.0
const JUMP_VELOCITY = 5.5

@export var sensivity = 0.01
@export var desination_position = Vector3(0,0,0)

var twist_input := 0.0
var pitch_input := 0.0
@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravitation = 1.0
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	gravity = gravity * gravitation

func _physics_process(delta):
	if(Input.is_action_just_pressed("esc")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta 


	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY*gravitation

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (twist_pivot.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED 
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-90),deg_to_rad(42))
	twist_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * sensivity * gravitation
			pitch_input = - event.relative.y * sensivity * gravitation
			



func _on_visibility_changed():
	pass # Replace with function body.


func _on_area_3d_area_entered(area):
	if area.is_in_group("Portal"):
		position = desination_position
		
