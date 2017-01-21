extends Node2D

var wave
var timespawn = 10
var acctime = 0

func _ready():
	set_fixed_process(true)
	wave = preload("res://wave/wave.tscn")

func _fixed_process(delta):
	acctime += delta
	if(acctime > timespawn):
		var newWave = wave.instance()
		newWave.set_pos(Vector2(0, 0))
		get_tree().get_root().add_child(newWave)
		acctime = 0