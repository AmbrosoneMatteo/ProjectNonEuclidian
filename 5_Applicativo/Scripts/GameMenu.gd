extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_option_button_pressed():
	for i in get_children():
		i.visible=false
	$Control.visible=true



func _on_exit_button_pressed():
	print("exiting to menu")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_to_menu_button_pressed():
	for i in get_children():
		i.visible=true
	$Control.visible=false
	$SaveGame.visible=false

func _on_save_button_pressed():
	for i in get_children():
		i.visible=false
	$SaveGame.visible=true
