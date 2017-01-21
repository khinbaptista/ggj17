extends Area2D

export(float) var damage = 10.0

func _ready():
	connect("body_enter", self, "corn_collision")

func corn_collision(body):
	if body.has_method("hit"):
		body.hit(damage)
