extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	reload()

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
				get_child(i).text=file % (i+1) as String

			
