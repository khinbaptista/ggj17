extends Node2D

var wave
var wave2
export var timespawn = 5
export var timetohard = 20
var acctime = 0
var totaltime = 0
var height
export var leftWay = false

func _ready():
	set_fixed_process(true)
	height = get_viewport().get_rect().size.y
	wave = preload("res://wave/wave.tscn")
	#wave2 = preload("res://wave/wave2.tscn")

func _fixed_process(delta):
	acctime += delta
	totaltime += delta
	if(totaltime > timetohard && timespawn > 2):
		timespawn = timespawn / 2
		totaltime = 0
	if(acctime > timespawn):
		var newWave
		newWave = wave.instance()
		if(leftWay):
			newWave.left = true
			newWave.set_pos(Vector2(700, rand_range(0.2*height, 0.8*height)))
		else:
			newWave.set_pos(Vector2(50, rand_range(0.2*height, 0.8*height)))
		get_tree().get_root().add_child(newWave)
		acctime = 0