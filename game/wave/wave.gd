extends KinematicBody2D

export(int) var speed = 500
export var left = false
var acclast = 0

func _ready():
	set_fixed_process(true)
	if(left):
		move(Vector2(-0.01*rand_range(20, 100), 0.01*rand_range(0, 100)))
	else:
		move(Vector2(0.01*rand_range(20, 100), 0.01*rand_range(0, 100)))
	
func _fixed_process(delta):
	acclast += delta
	var move_dir = changeDir().normalized()
	if(left):
		set_rot(Vector2(-1, 0).angle_to(get_travel()))
	else:
		set_rot(Vector2(1, 0).angle_to(get_travel()))
	var motion = move_dir * speed * delta
	move(motion)
	
func changeDir():
	if is_colliding() :
		acclast = 0
		return get_collision_normal().reflect(get_travel())
	else:
		return get_travel()
