#extends RigidBody2D
extends "corn.gd"

export(int) var speed = 10
export(int) var jump_impulse = 50
export(float, 0.1, 2.0, 0.1) var max_jump_duration = 0.5

var movement

var jumping
var jump_timer

func _ready():
	._ready()
	jumping = false
	jump_timer = 0.0
	
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	movement = Vector2()
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	
	if (Input.is_action_pressed("jump") and not jumping) or\
	Input.is_action_pressed("jump") and jump_timer < max_jump_duration:
		jumping = true
		jump_timer += delta
		apply_impulse(Vector2(), Vector2(0, -jump_impulse))
	else:
		jumping = false
		jump_timer = 0.0
	
	if jumping: print(jump_timer)

func _integrate_forces(state):
	if movement == Vector2(): return
	var velocity = state.get_linear_velocity()
	velocity += movement * speed
	set_linear_velocity(velocity)
