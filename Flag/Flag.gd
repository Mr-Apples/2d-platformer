extends Area2D

# Gets the animated sprite2d node
@onready var animator = $AnimatedSprite2D

# Gets the FadeTransition node
@onready var transition = $"../FadeTransition"

# Plays the flags windy animation on level load
func _ready():
	# Plays the flags windy animation
	animator.play("default")

# Loads the main menu if the player touches the flag, also updates the current level variable
func _on_body_entered(body):
	# Checks if the node that touched the flag is the player
	if body.name == "player":
		# Checks if the current level is the most reccently unlocked level for the player
		if get_tree().get_current_scene().get_name().to_int() == GlobalVars.CurrentLevel:
			# If so, add 1 to the current level variable
			GlobalVars.CurrentLevel = get_tree().get_current_scene().get_name().to_int() + 1
		# Switch the scene and also plays the scene transition
		transition.scene_transition("res://Level Selector/LevelSelector.tscn")
