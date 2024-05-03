extends Label

var content = "Stones: "

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(content,Global.stones_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(content,Global.stones_number)
