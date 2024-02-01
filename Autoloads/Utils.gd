extends Node

# Function to save the game
func save_game():
	# Print debugging info
	print("Saving Game")
	
	# Open the save file
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	# Get the save data
	var save_data = JSON.stringify(GlobalVars.CurrentLevel)
	
	# Save the save data to the save file
	save_file.store_line(save_data)
	
	# Print debugging info
	print("Saving Successful")
	
	# Quit the game
	get_tree().quit()

# Load the save game
func load_game():
	
	# Checks if the file exists, if not return the first level as current level
	if not FileAccess.file_exists("user://savegame.save"):
		print("No Savefile")
		return 1
	# Otherwise...
	else:
		# Open the save file
		var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
		
		# Read the data
		var jsonstring = save_file.get_line()
		
		# Instantiate a json object
		var json = JSON.new()
		
		# Parse the string
		var parse_result = json.parse(jsonstring)
		
		# If the parse was unsuccessful print debug info
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", jsonstring, " at line ", json.get_error_line())
			return
		
		# Load the read data
		GlobalVars.CurrentLevel = json.get_data()
		
		# Print debug info
		print("Loaded Savegame with level: " + str(json.get_data()))

# Load the save game on game load
func _ready():
	load_game()

# If the game quit notification is recieved then save the game
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
