extends Area2D

# The Fade Transition node
@onready var transition = $"../../FadeTransition"

# Triggered when spikes are touched
func _on_body_entered(body):
	# If the entering body is the player
	if body.name == "player":
		# Reload the current level in order to put the player at the start
		transition.scene_transition("res://Levels/" + get_tree().get_current_scene().get_name() + ".tscn")
