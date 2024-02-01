extends TextureButton

func _on_pressed():
	get_tree().paused = !get_tree().paused

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
