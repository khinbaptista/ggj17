extends Area2D

func _ready():
	connect("body_enter", self, "on_collision")

func on_collision(body):
	body.queue_free()
