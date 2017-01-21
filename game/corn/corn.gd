extends RigidBody2D

export(float, 0, 1000, 0.5) var health = 100.0
export(Color) var start_color = Color(1, 1, 1)
export(Color) var pop_color = Color(1, 1, 1)

export(int) var diff_anims = 5

var max_health
var anim

signal popped

func _ready():
	max_health = health
	anim = get_node("Sprite/AnimationPlayer")

func hit(damage):
	health -= damage
	get_node("Sprite").set_modulate(start_color.linear_interpolate(pop_color, (max_health - health) / max_health))
	
	selectAnim()
	
	if health <= 0:
		health = 0
		emit_signal("popped")

func selectAnim():
	var rate = max_health - health
	var interval = max_health / diff_anims
	if(rate >= 0 && rate < interval):
		changeAnim("stage0")
	elif(rate > interval && rate < 2*interval):
		changeAnim("Stage 1")
	elif(rate > 2*interval && rate < 3*interval):
		changeAnim("Stage 2")
	elif(rate > 3*interval && rate < 4*interval):
		changeAnim("Stage 3")
	elif(rate > 4*interval && rate < 5*interval):
		changeAnim("Stage 4")

func changeAnim(animName):
	anim.play(animName)
