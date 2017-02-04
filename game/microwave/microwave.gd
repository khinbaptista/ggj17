extends Node

export(String, FILE) var level_filepath;

var level_res;

var level_node;
var credits_node;

func _ready():
	level_res = load(level_filepath)
	credits_node = get_node("credits")
	credits_node.set_hidden(true)

func on_credits():
	credits_node.set_hidden(!credits_node.is_hidden())

func on_start():
	credits_node.set_hidden(true)
	get_node("gui/credits").set_disabled(true)
	
	level_node = level_res.instance()
	level_node.connect("game_over", self, "on_game_over")
	add_child(level_node)

func on_game_over(comemorate):
	pass

func on_quit():
	get_tree().quit()
