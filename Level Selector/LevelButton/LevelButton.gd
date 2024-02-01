extends PanelContainer

# The signal that is emitted when clicked, gives the level that should be loaded as an argument
signal clicked(level)

# Should the button display a lock and not load the level
@export var locked = true

# The level that the button loads
@export var levelnum = ""

# The label used to display the levelnumber
@onready var label = $MarginContainer/Label

# The image of a lock
@onready var lockimage = $MarginContainer/TextureRect

# Used to set the lock status of the button
func set_locked(value):
	# Checks if the node is in the scene tree yet, if not then wait until the node is
	if not is_inside_tree():
		# Wait until in scene tree
		await ready
	# Hide or Show lock
	lockimage.visible = value
	# Hide or Show label
	label.visible = not value

# Sets the level number
func set_levelnum(newnum: String):
	# Changes the text of the label
	label.text = newnum

# Used to initialise the button
func init(setnum):
	# Set the level number to the given number
	levelnum = setnum
	
	# Changes the label text
	$MarginContainer/Label.text = setnum
	
	# Checks if the levelnumber is equal to or less than the current level
	if int(levelnum) <= GlobalVars.CurrentLevel:
		# If true than set the button to not locked
		locked = false
	else:
		# Else set the button to loccked
		locked = true
	# Use set locked to actually change the value
	set_locked(locked)

# Loads the level the node is a button for
func load_level():
	# Emits the signal that tells the FadeTransition to load a given level
	clicked.emit("res://Levels/" + levelnum + ".tscn")

# Loads the level when clicked
func _on_gui_input(event):
	# If locked do nothing
	if locked:
		return
	# If the input was a mouse click
	if event is InputEventMouseButton and event.pressed:
		# Load the level
		load_level()
