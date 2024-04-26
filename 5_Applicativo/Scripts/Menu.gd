extends Node

@onready var start_button = $MainMenuOptions/VBoxContainer/start_button
@onready var load_button = $MainMenuOptions/VBoxContainer/load_button
@onready var option_button = $MainMenuOptions/VBoxContainer/option_button
@onready var exit_button = $MainMenuOptions/VBoxContainer/exit_button

func _ready():
	start_button.connect("pressed", Callable(self, "lets_play"))
	exit_button.connect("pressed", Callable(self, "exit"))
	option_button.connect("pressed", Callable(self, "go_to_option"))
	load_button.connect("pressed", Callable(self, "go_to_loadgame"))


func exit():
	get_tree().quit()

func go_to_option():
	$MainMenuOptions.visible = false
	$OptionsMenu/VBoxContainer.visible = true
	$LoadGame.visible = false
	
func go_to_menu():
	$MainMenuOptions.visible = true
	$OptionsMenu/VBoxContainer.visible = false
	$LoadGame.visible = false
	
func go_to_loadgame():
	$MainMenuOptions.visible = false
	$OptionsMenu/VBoxContainer.visible = false
	$LoadGame.visible = true

func lets_play():
	print("Menu.gd: lets_play")
	Global.reset()
	get_tree().change_scene_to_file("res://Scenes/start.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func continue_game():
	pass
