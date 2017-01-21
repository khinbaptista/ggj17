extends RigidBody2D

export(int, 0, 1000) var health = 100
export(Color) var start_color
export(Color) var pop_color

var max_health

signal popped

func _ready():
	max_health = health

func hit(damage):
	health -= damage
	
	if health <= 0:
		health = 0
		emit_signal("popped")
