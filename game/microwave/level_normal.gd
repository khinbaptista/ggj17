extends Node

signal game_over

var player

func _ready():
	player = get_node("player_corn")
	player.connect("popped", self, "emit_signal", ["game_over"])
