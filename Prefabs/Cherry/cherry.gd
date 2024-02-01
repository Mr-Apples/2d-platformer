extends Area2D

@onready var animator = $AnimatedSprite2D

func _ready():
	animator.play("default")

func _on_body_entered(body):
	if body.name == "player":
		animator.play("collected")
		await animator.animation_finished
		self.queue_free()
