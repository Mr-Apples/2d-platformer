extends TextureButton

@onready var transition = $"../../../../FadeTransition"

func _on_pressed():
	transition.scene_transition("res://main_menu.tscn")
