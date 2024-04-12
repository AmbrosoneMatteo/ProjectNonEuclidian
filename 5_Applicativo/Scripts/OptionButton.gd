extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	var resolutions = ["640x480", "1280x1024","1600x1200","1920x1080","1920x1200","3440x1440","3840x2160"]
	for i in resolutions:
		add_item(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var window = get_window()
	var x = get_item_text(selected)
	x = x.substr(0,x.find("x"))
	var y = get_item_text(selected)
	y = y.substr(y.find("x")+1, len(y))
	print(y)


func _on_item_selected(index):
	var viewport = get_viewport()
	var window = get_window()
	var x = get_item_text(index)
	x = x.substr(0,x.find("x"))
	var y = get_item_text(index)
	y = y.substr(y.find("x")+1, len(y))
	print(x,y)
	viewport.size.x=int(x)
	viewport.size.y=int(y)
