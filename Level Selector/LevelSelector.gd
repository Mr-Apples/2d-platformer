extends MarginContainer

# The parralax background
@onready var parabg = $ParallaxBackground

# The FadeTransition node
@onready var transition = $FadeTransition

# Preload the levelbutton to improve the loading time
var levelbutton = preload("res://Level Selector/LevelButton/LevelButton.tscn")

# The the contents of a directory
func dir_contents(path):
	# Open the directory
	var dir = DirAccess.open(path)
	
	# Initiaise a list for the files
	var files = []
	
	# If the list is not empty then start listing it
	if dir:
		# Start listing directory
		dir.list_dir_begin()
		# Append the first file to the list

		# Create a variable to use for iteration of the files
		var file_name
		
		# Loop through files in directory
		while true:
			# Get the file
			file_name = dir.get_next()
			
			# If the filename is empty (reached end of list), then break
			if file_name == "":
				break
			
			if '.remap' in file_name: # Fix .tscn.remap.tscn bug
				file_name = file_name.trim_suffix('.remap')
			
			# Add the file to the list
			files.append(file_name)
		# Sort the list	
		files.sort_custom(_sort_name)
		
		# Print Debug Info
		print(files)
		
		# Return the list
		return files

func load_level_buttons():
	var levels = dir_contents("res://Levels")
	for level in levels:
		level = level.trim_suffix(".tscn")
		var newlevel = levelbutton.instantiate()
		newlevel.init(level)
		$MarginContainer/HBoxContainer/ClipControl/LevelBox.add_child(newlevel)
		get_node("MarginContainer/HBoxContainer/ClipControl/LevelBox/" + newlevel.name).clicked.connect(load_level)

func load_level(level):
	transition.scene_transition(level)

func _ready():
	load_level_buttons()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		transition.scene_transition("res://main_menu.tscn")

func _sort_name(a, b) -> bool:
	a = int(a.rstrip(".tscn"))
	b = int(b.rstrip(".tscn"))
	return a < b
