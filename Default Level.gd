extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Print Debug Info
	print("Loaded Level: " + get_tree().get_current_scene().get_name())
