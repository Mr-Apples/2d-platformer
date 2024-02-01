extends Area2D

signal flicked(state)

@export var state = false

@onready var animator = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if state:
		animator.play("active")
	else:
		animator.play("inactive")
	flicked.emit(state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.name == "player":
		state = !state
		if state:
			animator.play("active")
		else:
			animator.play("inactive")
		flicked.emit(state)
