extends Control


var input_selected: String = "null"
@onready var keys = $Keys/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in keys.get_children():
		print(i.name.substr(0, i.name.find("_")).to_lower())
		var actions = InputMap.action_get_events(i.name.substr(0, i.name.find("_")).to_lower())
		i.text = ""
		for l in actions:
			i.text += l.as_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _input(event):
#	if event is InputEventKey and input_selected!="null":
#		InputMap.erase_action(input_selected)
#		InputMap.add_action(input_selected)
#		InputMap.action_add_event(input_selected, event.keycode)
			
func _on_key_pressed(input: String):
	input_selected = input

func _input(ev):
	if input_selected!="null" and not ev is InputEventMouse:
		InputMap.action_erase_events(input_selected)
		InputMap.action_add_event(input_selected, ev)
		var search = input_selected.substr(0,1).to_upper()+input_selected.substr(1,len(input_selected))+"_button"
		get_node("Keys/"+search).text = ev.as_text()
		input_selected = "null"
