extends Label

var content = "Sassi: "

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(content,Global.numero_sassi)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(content,Global.numero_sassi)
