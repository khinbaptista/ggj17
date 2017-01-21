extends Area2D

var explosion_power = 10000
var radius

var popcorn_res

func _ready():
	popcorn_res = preload("res://popcorn/popcorn.tscn")
	get_parent().connect("popped", self, "explode")
	radius = get_node("CollisionShape2D").get_shape().get_radius()

func explode():
	var bodies_inside = get_overlapping_bodies()
	for body in bodies_inside:
		if(body extends RigidBody2D):
			var vec = body.get_global_pos() - get_global_pos()
			var impulse = vec.normalized() * explosion_power * (1 - vec.length() / radius)
			body.apply_impulse(Vector2(0, 0), impulse)
	var popcorn = popcorn_res.instance();
	popcorn.set_global_pos(get_global_pos())
	get_parent().get_parent().add_child(popcorn)
	get_parent().queue_free()