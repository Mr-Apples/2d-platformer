extends CharacterBody2D

# The animator of the player
@onready var animator = $AnimationPlayer

# The Animated sprite of the player
@onready var sprite = $AnimatedSprite2D

# The speed of the player
const SPEED = 200.0

var has_cherry = false

# The jump velocity of the player
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# The physics process of the player
func _physics_process(delta):
	# Do nothing if the player is frozen
	if !GlobalVars.is_player_freezed:
		# If not on the floor
		if not is_on_floor():
			# Apply the gravity force
			velocity.y += gravity * delta
			# If still going up play jump animation
			if velocity.y < 0:
				animator.play("Jump")
			# Else play fall animation
			elif velocity.y > 0:
				animator.play("Fall")

		# If the jump button was pressed and the player is on the floor
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			# Apply the jump_velocity to the player
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		var direction = Input.get_axis("Left", "Right")
		# Input was recieved
		if direction:
			# Set velocity.x to the direction times the speed
			velocity.x = direction * SPEED
			
			# Check the direction and flip the sprite the correct direction
			if direction > 0:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
			
			# If not moving up or down play the running animation
			if velocity.y == 0:
				animator.play('Run')
		# Otherwise stand still and play idle animation
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				animator.play("Idle")
		# Apply the velocity changes to the player
		move_and_slide()


func _on_enemy_bouncer_body_entered(body):
	if body in get_tree().get_nodes_in_group("Enemies"):
		velocity.y = -350


func _on_slime_detecter_bottom_triggered(_body):
	var landvel = velocity
	await get_tree().create_timer(0.1).timeout
	velocity.y = -landvel.y
