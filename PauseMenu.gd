extends CanvasLayer


func _init():
	self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_tree().paused:
		self.show()
	else:
		self.hide()
