extends KinematicBody2D

export(int) var speed = 300

func _ready():
	set_fixed_process(true)
	move(Vector2(0.01*rand_range(0, 100), 0.01*rand_range(0, 100)))
	
func _fixed_process(delta):
	var move_dir = changeDir().normalized()
	var motion = move_dir * speed * delta
	move(motion)
	
func changeDir():
	if is_colliding():
		return get_collision_normal().reflect(get_travel())
	else:
		return get_travel()
