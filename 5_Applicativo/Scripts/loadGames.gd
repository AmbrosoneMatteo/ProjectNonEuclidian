extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_reload_pressed():
	reload()

func reload():
	for i in range(0,5):
		var file = "user://player_data-%s.json"
		if FileAccess.file_exists(file % (i+1) as String):
			var json_as_text = FileAccess.get_file_as_string(file % (i+1) as String)
			var json_as_dict = JSON.parse_string(json_as_text)
			if json_as_dict:
				var node = "Slot-%s"
				get_node(node % str(i+1)).text=str(file % (i+1))

func loadGame(slot):
	var file = "user://player_data-%s.json"
	if FileAccess.file_exists(file % slot as String):
		var json_as_text = FileAccess.get_file_as_string(file % slot as String)
		var json_as_dict = JSON.parse_string(json_as_text)
		if json_as_dict:
			Global.collected_statues = json_as_dict.collected_statues
			Global.player_position=stringToVector(json_as_dict.player_position)
			Global.stones_number = int(json_as_dict.stones_number)
			for stone_position_string in json_as_dict.stones_placed:
				Global.stones_placed.append(stringToVector(stone_position_string))
			Global.tutoria_watched = true
			loadScene()


func stringToVector(input_string: String) -> Vector3:
	# Remove parentheses and split by commas
	var components = input_string.replace("(", "").replace(")", "").split(",")

	# Convert substrings to floats
	var x = components[0].to_float()
	var y = components[1].to_float()
	var z = components[2].to_float()

	# Create a Vector3
	var result_vector = Vector3(x, y, z)
	return result_vector

func loadScene():
	var scene_path = "res://Scenes/start.tscn"
	# Avvia la scena
	get_tree().change_scene_to_file(scene_path)


func _on_visibility_changed():
	reload()
