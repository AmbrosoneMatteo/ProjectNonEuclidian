extends VBoxContainer


@onready var volume_options = $Control/Volume
@onready var keymap_options = $Control/KeyMap
@onready var resolution_options = $Control/ResolutionMenu
@onready var buttons = $Buttons
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_volume_button_pressed():
	buttons.visible = false
	volume_options.visible=true
	keymap_options.visible=false
	resolution_options.visible=false
	
func _go_back():
	volume_options.visible=false
	keymap_options.visible=false
	buttons.visible = true
	resolution_options.visible=false


func _on_keymap_button_pressed():
	buttons.visible = false
	volume_options.visible=false
	keymap_options.visible=true
	resolution_options.visible=false

func _on_resolution_button_pressed():
	buttons.visible = false
	volume_options.visible=false
	keymap_options.visible=false
	resolution_options.visible=true
	
	

