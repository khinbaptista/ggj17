extends Node

export(String, FILE) var level_filepath

var level_res
var level_node
var credits_node

var sfx_node
var bgm_node

var timer
export(int, 0, 9) var minutes = 3
export(int, 0, 59) var seconds = 30

func _ready():
	level_res = load(level_filepath)
	credits_node = get_node("credits")
	credits_node.set_hidden(true)
	
	sfx_node = get_node("sfx")
	bgm_node = get_node("bgm")
	
	timer = get_node("gui/timer")
	timer.connect("game_timeout", self, "on_game_over", [true])

func on_credits():
	sfx_node.play("ping")
	credits_node.set_hidden(!credits_node.is_hidden())

func on_start():
	sfx_node.play("ping")
	
	credits_node.set_hidden(true)
	get_node("gui/credits").set_disabled(true)
	get_node("gui/popcorn").set_disabled(true)
	
	get_node("gui/title").set_hidden(true)
	get_node("gui/comemoration").set_hidden(true)
	
	level_node = level_res.instance()
	level_node.connect("game_over", self, "on_game_over", [false])
	add_child(level_node)
	
	timer.minutes = minutes
	timer.seconds = seconds
	timer.start_display()
	
	bgm_node.play("pipo")
	var voice = sfx_node.play("microwave_starting")
	while sfx_node.is_voice_active(voice): yield(get_tree(), "idle_frame")
	voice = sfx_node.play("microwave_noise")

func on_game_over(comemorate):
	level_node.queue_free()
	timer.clear_timer()
	
	get_node("gui/credits").set_disabled(false)
	get_node("gui/popcorn").set_disabled(false)
	get_node("gui/title").set_hidden(false)
	
	if comemorate:
		get_node("gui/comemoration").set_hidden(false)
		sfx_node.play("comemoration", true)

func on_quit():
	get_tree().quit()
