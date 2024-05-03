extends Label
var content = "Statues: "

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(content,len(Global.collected_statues),"/",15)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if not event is InputEventMouse:
		text = str(content,len(Global.collected_statues),"/",15)
