#extends RigidBody2D
extends "corn.gd"

export(int) var speed = 10
export(int) var jump_impulse = 50
export(float, 0.1, 2.0, 0.1) var max_jump_duration = 0.5

export(int, 0, 1000) var ground_test_distance = 10

var movement

var grounded
var jumping
var jump_timer

func _ready():
	._ready()
	grounded = false
	jumping = false
	jump_timer = 0.0
	
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	grounded = is_grounded()
	movement = Vector2()
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	
	if Input.is_action_pressed("jump") and jumping and jump_timer < max_jump_duration:
		jump_timer += delta
		apply_impulse(Vector2(), Vector2(0, -jump_impulse))
	else:
		jumping = false
		jump_timer = 0.0
	
	if jumping: print(jump_timer)

func _input(event):
	if event.is_action_pressed("jump") and not event.is_echo() and not jumping and grounded:
		jumping = true
	elif event.type == InputEvent.KEY and event.scancode == KEY_RETURN:
		shockwave()

func _integrate_forces(state):
	if movement == Vector2(): return
	var velocity = state.get_linear_velocity()
	velocity += movement * speed
	set_linear_velocity(velocity);

func is_grounded():
	var global_pos = get_global_pos()
	var space = get_world_2d().get_direct_space_state()
	var cast = space.intersect_ray(global_pos, global_pos + Vector2(0, ground_test_distance))
	
	return not cast.empty()

func shockwave():
	pass
