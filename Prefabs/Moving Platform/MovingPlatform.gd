extends AnimatableBody2D

var tween: Tween

@onready var animator = $AnimatedSprite2D

@export var waypoints: Array[Node2D]

@export var move_duration = 2

var current_waypoint = 0

@export var moving = true

@export var easingfunction = Tween.TRANS_CUBIC

func _process(_delta):
	set_current_waypoint()

func set_current_waypoint():
	if position == waypoints[current_waypoint].position:
		current_waypoint += 1
		if current_waypoint >= waypoints.size():
			current_waypoint = 0
		tween_pos()

func tween_pos():
	if moving:
		tween = create_tween().set_trans(easingfunction)
		tween.tween_property(self, "position", waypoints[current_waypoint].position, move_duration)

func _ready():
		tween_pos()

func toggle_move(state):
	await get_tree().create_timer(0.1).timeout
	if state:
		moving = true
		animator.play("default")
		tween.play()
	else:
		moving = false
		$AnimatedSprite2D.pause()
		tween.pause()
