extends Node2D

# The parrallax background
@onready var paraBG = $ParallaxBackground

# The Fadetransition
@onready var transition = $FadeTransition

# Called when the play button is clickedd
func _play():
	# Use the fade transition to load the level seletion menu
	transition.scene_transition("res://Level Selector/LevelSelector.tscn")

# Called when the quit button is clicked
func _quit():
	# Save the game
	Utils.save_game()

func _ready():
	# Set the parralax background to the correct scroll offset
	paraBG.scroll_offset.x = GlobalVars.ParralaxBGOffset
