extends Node2D

export(int) var speed = 50

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var move_dir = Vector2(1, 0)
	var motion = move_dir * speed * delta
	set_pos(get_pos() + motion)