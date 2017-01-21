extends RigidBody2D

export(float, 0, 1000, 0.5) var health = 100.0
export(Color) var start_color
export(Color) var pop_color

var max_health

signal popped

func _ready():
	max_health = health

func hit(damage):
	health -= damage
	get_node("Sprite").set_modulate(start_color.linear_interpolate(pop_color, (max_health - health) / max_health))
	
	if health <= 0:
		health = 0
		emit_signal("popped")
