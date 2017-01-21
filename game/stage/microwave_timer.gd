extends Node

export(NodePath) var display_sec_unit
export(NodePath) var display_sec_ten
export(NodePath) var display_min_unit

var sec_unit
var sec_ten
var min_unit

var timer_font

func _ready():
	sec_unit = get_node(display_sec_unit)
	sec_ten = get_node(display_sec_ten)
	min_unit = get_node(display_min_unit)

func set_display(minutes, seconds):
	pass
