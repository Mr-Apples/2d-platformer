extends ParallaxBackground

# The speed of the parralax backgroundd
@export var SPEED = 100

# Moves the platform
func _process(delta):
	# Move the position of the background
	scroll_offset.x += SPEED * delta
	
	# Update the global positionn of the parralax background
	GlobalVars.ParralaxBGOffset = scroll_offset.x
