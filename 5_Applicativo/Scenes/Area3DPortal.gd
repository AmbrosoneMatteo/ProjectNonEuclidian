extends Area3D

#@onready var player = $
var entered = false


func _on_body_entered(body: PhysicsBody3D):
	entered = true


func _on_body_exited(body: PhysicsBody3D):
	entered = false

func _process(delta):
	#print(player)
	if entered:
		if Input.is_action_just_pressed("ui_accept"):
			print()
