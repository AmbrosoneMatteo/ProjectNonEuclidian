extends Control


var input_selected: String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		InputMap.erase_action(input_selected)
		InputMap.add_action(input_selected)
		InputMap.action_add_event(input_selected, event.keycode)
			
func _on_key_pressed(input: String):
	input_selected = input
