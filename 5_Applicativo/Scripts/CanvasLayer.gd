extends CanvasLayer
# Called when the node enters the scene tree for the first time.

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	pass
#		# Imposta l'opacità iniziale a 1 per un'overlay completamente nero
#	if Input.is_action_just_pressed("Accept"):
#		var tween: Tween = get_tree().create_tween()
#		$ColorRect.modulate.a = 1.0
#
#		tween.interpolate_proprety($ColorRect, "modulate:a", 1.0, 0.0, fade_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		tween.tween_callback($ColorRect.queue_free)
#		tween.play()
#	# Controlla se la dissolvenza è terminata
#	if not animatiom_player.is_active():
#		# Rimuovi il CanvasLayer una volta che la dissolvenza è terminata
#		queue_free()
#		print("removing children")



func _on_continue_button_pressed():
	$GameMenu.visible=false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused=false


