extends Node

@onready var start_button = $MainMenuOptions/VBoxContainer/start_button
@onready var continue_button = $MainMenuOptions/VBoxContainer/continue_button
@onready var option_button = $MainMenuOptions/VBoxContainer/option_button
@onready var exit_button = $MainMenuOptions/VBoxContainer/exit_button
@onready var to_menu_button = $OptionsMenu/Control/to_menu_button
@onready var to_main_button = $LoadGame/VBoxContainer/to_menu_button

func _ready():
	start_button.connect("pressed", Callable(self, "lets_play"))
	exit_button.connect("pressed", Callable(self, "exit"))
	option_button.connect("pressed", Callable(self, "go_to_option"))
	to_menu_button.connect("pressed", Callable(self, "go_to_menu"))
	to_main_button.connect("pressed", Callable(self, "go_to_menu"))
	continue_button.connect("pressed", Callable(self, "go_to_loadgame"))

func exit():
	get_tree().quit()

func go_to_option():
	$MainMenuOptions.visible = false
	$OptionsMenu.visible = true
	$LoadGame.visible = false
	
func go_to_menu():
	$MainMenuOptions.visible = true
	$OptionsMenu.visible = false
	$LoadGame.visible = false
	
func go_to_loadgame():
	$MainMenuOptions.visible = false
	$OptionsMenu.visible = false
	$LoadGame.visible = true

func lets_play():
	get_tree().change_scene_to_file("res://Scenes/start.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
