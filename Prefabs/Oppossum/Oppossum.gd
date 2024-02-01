extends CharacterBody2D

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var moveleft = true

var speed = 50

@onready var animator = $AnimatedSprite2D

var isdieing = false

func _ready():
	animator.play("default")
	if randi() % 2:
		moveleft = false

func _physics_process(delta):
	# Apply gravity
	if !is_on_floor():
		velocity.y += gravity * delta
	
	# Move horizontally
	if moveleft:
		velocity.x = -speed
		animator.flip_h = false
	else:
		velocity.x = speed
		animator.flip_h = true
	
	move_and_slide()


func _on_right_detector_body_entered(body):
	if body != self and !isdieing:
		if body.name == "player":
			get_node("../FadeTransition").scene_transition("res://Levels/" + get_tree().get_current_scene().get_name() + ".tscn")
		if body.name != "player":
			moveleft = false


func _on_left_detector_body_entered(body):
	if body != self and !isdieing:
		if body.name == "player":
			get_node("../FadeTransition").scene_transition("res://Levels/" + get_tree().get_current_scene().get_name() + ".tscn")
		if body.name != "player":
			moveleft = true


func _on_death_detector_body_entered(body):
	if body.name == "player":
		isdieing = true
		animator.play("death")
		await animator.animation_finished
		queue_free()
