extends Area2D

var bodies_inside
var radius

func _ready():
	get_parent().connect("popped", self, "explode")

func explode():
	bodies_inside = get_overlapping_bodies()
	radius = get_node("CollisionShape2D").get_shape().get_radius()
	for body in bodies_inside:
		if(body extends RigidBody2D):
			var vec = body.get_pos() - get_pos()
			vec = vec.normalized()
			var impulse = vec * (1 - vec.length()/radius)
			body.apply_impulse(Vector2(0, 0), impulse)	