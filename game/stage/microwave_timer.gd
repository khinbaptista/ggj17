extends Node

export(float, 0.1, 5.0, 0.1) var time_scale = 2.0
export(int, 0, 9) var minutes = 3
export(int, 0, 59) var seconds = 30

var sec_unit
var sec_ten
var min_unit

var timer_font
var timer

signal game_timeout

func _ready():
	sec_unit = get_node("sec_unit")
	sec_ten = get_node("sec_ten")
	min_unit = get_node("min_unit")
	
	timer = Timer.new()
	#timer.set_wait_timer(((minutes * 60) + seconds) / time_scale)
	timer.set_wait_time(1.0 / time_scale)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "elapsed_second")
	timer.set_autostart(true)
	add_child(timer)
	set_display(minutes, seconds)

func elapsed_second():
	if seconds == 0:
		if minutes > 0:
			seconds = 59
			minutes -= 1
		else:
			emit_signal("game_timeout")
	else:
		seconds -= 1
	set_display(minutes, seconds)

func set_display(m, s):
	if m < 10 and m >= 0:
		min_unit.set_frame(m)
	if s >= 0 and s < 60:
		sec_unit.set_frame(s % 10)
		sec_ten.set_frame(floor(s / 10))
