extends CharacterBody3D

var statue_nodes = []
var statue_control = null


var SPEED = 14.0
@export var JUMP_VELOCITY = 10

@export var portal = 0
@export var sensivity = 0.01
@export var desination_position = Vector3(0,0,0)
@export var bonus = 0.0
var sound_player = AudioStreamPlayer.new()
var audio_stream = load("res://Scenes/Sounds/SoundEffects/footstep.mp3")

var pickup_sound = AudioStreamPlayer.new()
var pickup_stream = load("res://Scenes/Sounds/SoundEffects/pickup.mp3")

var tutorial_voice = AudioStreamPlayer.new()
var tutorial_stream = load("res://Scenes/Sounds/SoundEffects/tutorial_eng.mp3")
var fall_counter:float = 0.0

var twist_input := 0.0
var pitch_input := 0.0
var tutorial_finished: bool = false
@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var raycast := $TwistPivot/PitchPivot/RayCast3D
@onready var Variables = get_node("/root/Global")
@onready var tutorial = $TwistPivot/PitchPivot/Camera3D/CanvasLayer/Tutorial
@onready var camera = $TwistPivot/PitchPivot/Camera3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravitation = 1.0
func _ready():
	
	sound_player.volume_db = -40.0 + Global.sound_volume/2
	pickup_sound.volume_db = -40.0 + Global.sound_volume/2
	tutorial_voice.volume_db = -40.0 + Global.sound_volume/2
	add_child(pickup_sound)
	add_child(tutorial_voice)
	pickup_sound.stream = pickup_stream
	tutorial_voice.stream = tutorial_stream
	#tutorial_voice.play()


func _process(_delta):
	if Input.is_action_just_pressed("drop"):
		place_stone()
		
	if Input.is_action_just_pressed("Accept") or Global.tutorial_watched:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if(Input.is_action_just_pressed("pickup")):
		pickup_sound.play()
	if Input.is_action_just_pressed("Accept") or Global.tutorial_watched:
		tutorial.visible = false
		tutorial_voice.stop()
	if(Input.is_action_just_pressed("esc")):
		get_tree().paused=true
		tutorial.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		tutorial_voice.stop()
		$TwistPivot/PitchPivot/Camera3D/CanvasLayer/GameMenu.visible = true
	if not tutorial_finished:
		if tutorial_voice.playing:
			Global.music_volume = 30
		else:
			while(Global.music_volume<80):
				Global.music_volume+=1
			tutorial_finished =true
		
	# Add the gravity.
	if not is_on_floor() and not is_on_ceiling():
		velocity.y -= gravity * delta 
		fall_counter+=delta
		if fall_counter > 15+bonus:
			Global.gameover=true
			get_tree().paused=true
			tutorial.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			tutorial_voice.stop()
			$TwistPivot/PitchPivot/Camera3D/CanvasLayer/GameMenu.visible = true
	if is_on_floor() or is_on_ceiling():
		fall_counter=0
		bonus=0
	print(gravity," - ",gravitation)

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and ((is_on_floor() and gravitation==1) or (is_on_ceiling() and gravitation==-1)) and not tutorial.visible:
		velocity.y = JUMP_VELOCITY*gravitation

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not tutorial.visible:
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
	pitch_pivot.rotate_x(pitch_input*gravitation)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-80),deg_to_rad(80))
	twist_input = 0.0 #it stops the camera from slipping
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
		print("going from: ",position," -> ", desination_position)
		portal = (portal+1)%2
		position = desination_position

# Ritorna true se la distanza tra i 2 vettori è minore di max_distance 
func is_near(pos,max_distance):
	var distance = calculate_distance(pos,position) # Viene calcolata la distranza tra i vettori
	if distance < max_distance:
		return true
	return false

func calculate_distance(vector1: Vector3, vector2: Vector3) -> float:
	return vector1.distance_to(vector2)

func place_stone():
	if(Global.stones_number>0):
		var pos = raycast.get_collision_point()
		if is_near(pos,4):
			Global.stones_number = Global.stones_number - 1
			Global.create_stone(pos)


func _on_slot_button_pressed(slot):
	var data_to_save = {"player_position": self.global_transform.origin,
	"twis_rotation": $TwistPivot.global_rotation,
	"pitch_rotation": $TwistPivot/PitchPivot.global_rotation,
	"graviy_direction": "upwards",
	 "saved_date": Time.get_date_dict_from_system(),
	 "statues_captured": {},
	 "rock_picked": {} ,
	 "stones_number": Global.stones_number,
	 "sassi": Global.sassi_posionati}
	var json_string := JSON.stringify(data_to_save)
	var save_path := "user://player_data-%s.json"
	var file_access	:= FileAccess.open(save_path % slot as String , FileAccess.WRITE)
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return
	file_access.store_line(json_string)
	file_access.close()
	print("game has been saved")
	get_node("TwistPivot/PitchPivot/Camera3D/CanvasLayer/GameMenu/VBoxContainer/SaveGame/VBoxContainer").reload()
	
func reload():
	pass # Replace with function body.

func _on_statue_touched(body, id:int):
	if body.name=="Player":
		if Input.is_action_just_pressed("pickup_object"):
			print("statue" + " id " + (str)(id) + " " + "removed")
			Global.statue_posizionate.append(id)
			var statua = $"../Statua".get_child(id)
			$"../Statua".remove_child(statua)
