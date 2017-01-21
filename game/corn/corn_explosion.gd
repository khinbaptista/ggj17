extends Area2D

#export(float)
var explosion_power = 10000
var radius

func _ready():
	get_parent().connect("popped", self, "explode")
	radius = get_node("CollisionShape2D").get_shape().get_radius()

func explode():
	var bodies_inside = get_overlapping_bodies()
	for body in bodies_inside:
		if(body extends RigidBody2D):
			var vec = body.get_global_pos() - get_global_pos()
			# vec = vec.normalized()
			var impulse = vec.normalized() * explosion_power * (1 - vec.length() / radius)
			body.apply_impulse(Vector2(0, 0), impulse)	
			#body.queue_free()