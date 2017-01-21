extends Node2D

var wave
export var timespawn = 5
export var timetohard = 20
var acctime = 0
var totaltime = 0
var height

func _ready():
	set_fixed_process(true)
	height = get_viewport().get_rect().size.y
	wave = preload("res://wave/wave.tscn")

func _fixed_process(delta):
	acctime += delta
	totaltime += delta
	if(totaltime > timetohard && timespawn > 2):
		timespawn = timespawn / 2
		totaltime = 0
	if(acctime > timespawn):
		var newWave = wave.instance()
		newWave.set_pos(Vector2(50, rand_range(0.2*height, 0.8*height)))
		get_tree().get_root().add_child(newWave)
		acctime = 0