extends Control


var input_selected: String = "null"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _input(event):
#	if event is InputEventKey and input_selected!="null":
#		InputMap.erase_action(input_selected)
#		InputMap.add_action(input_selected)
#		InputMap.action_add_event(input_selected, event.keycode)
			
#When a button is clicked it updates the input_select variable
#with the InputMap action that must be updated
func _on_key_pressed(input: String):
	print("connection from ",input)
	input_selected = input

#when the player has clicked a button and pressed a key it updates the InputMap 
#and resets the input_selected variable
func _input(ev):
	if input_selected!="null" and not ev is InputEventMouse:
		InputMap.action_erase_events(input_selected)
		InputMap.action_add_event(input_selected, ev)
		var search = input_selected.substr(0,1).to_upper()+input_selected.substr(1,len(input_selected))+"_button"
		get_node("Keys/VBoxContainer/"+search).text = ev.as_text()
		input_selected = "null"
