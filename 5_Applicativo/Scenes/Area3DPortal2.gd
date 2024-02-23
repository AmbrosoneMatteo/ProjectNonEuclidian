extends Area3D


var entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	entered = true

func _on_Area3D_body_exited(body):
	entered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true:
		pass
		#if Input.is_action_just_pressed("ui_accept"):
			#get_tree().change_scene("res:/Scenes/room_001.tscn")
