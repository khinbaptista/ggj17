extends Node2D

var wave
export var timespawn = 10
var acctime = 0
var height

func _ready():
	set_fixed_process(true)
	height = get_viewport().get_rect().size.y
	wave = preload("res://wave/wave.tscn")

func _fixed_process(delta):
	acctime += delta
	if(acctime > timespawn):
		var newWave = wave.instance()
		newWave.set_pos(Vector2(0, rand_range(0, height)))
		get_tree().get_root().add_child(newWave)
		acctime = 0