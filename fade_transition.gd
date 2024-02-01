extends ColorRect

# Gets the animation player node
@onready var animator = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Unhides automatically (Allows for it to be hidden in the editor to allow a bettter view of the sceenes)
	show()
	
	# Plays the animation backwards to make it look like the screen in fading out
	animator.play_backwards("fadetransition")
	
	# Unfreezes the player if it was frozen
	GlobalVars.is_player_freezed = false

# Plays the transition animation
func transition():
	animator.play("fadetransition")

# Plays the transition animation and also changes the scene, takes the scene to be changed to as an argument
func scene_transition(scene: String):
	# Freezes the player (In case they died or finished the level)
	GlobalVars.is_player_freezed = true
	
	# Play the transition animation
	transition()
	
	# Waits till the transition animtation finishes
	await animator.animation_finished
	
	# Print Debugging Info
	print("Loading Scene: " + scene)
	print("New Current Level: " + str(GlobalVars.CurrentLevel))
	
	# Unpause
	get_tree().paused = false
	
	# Change the scene
	get_tree().change_scene_to_file(scene)
