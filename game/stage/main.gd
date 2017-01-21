extends Node

var player_node
var player_pos

func _ready():
	# Pause
	get_tree().set_pause(true)
	
	setHideKernels(true)
	get_node("menu/popcorn").connect("microwave_start", self, "on_start")
	
	player_node = get_node("player_corn")
	player_pos = player_node.get_pos()
	
func setHideKernels(value):
	# Hide kernels
	var kernels = get_node("corns").get_children()
	for kernel in kernels:
		kernel.set_hidden(value)

func on_start():
	# Unpause
	get_tree().set_pause(false)
	
	setHideKernels(false)
	
	# Start display
	var display = get_node("display")
	display.minutes = 3
	display.seconds = 30
	display.start_display()
	
	# Hide other elements
	get_node("menu/quit/door").hide()
	get_node("menu/Sprite").hide()
	
	# Disable buttons
	get_node("menu/popcorn").set_disabled(true)
	get_node("menu/credits").set_disabled(true)
	
	player_node.connect("popped", self, "on_game_over")
	
func on_game_over():
	# Pause
	get_tree().set_pause(true)
	
	# Enable buttons
	get_node("menu/popcorn").set_disabled(false)
	get_node("menu/credits").set_disabled(false)
	
	# Reload kernels
	get_node("corns").free()
	var nodes_res = preload("res://corn/corn_collection.tscn")
	var node_collection = nodes_res.instance()
	node_collection.set_name("corns")
	add_child(node_collection)
	
	var player_res = preload("res://corn/player_corn.tscn")
	player_node = player_res.instance()
	#player_node.set_name("player_corn")
	
	add_child(player_node)
	player_node.set_global_pos(player_pos)
	#player_node.connect("popped", self, "on_game_over")
	
	# Reveal other elements
	get_node("menu/quit/door").show()
	get_node("menu/Sprite").show()
	
	# Hide again
	setHideKernels(true)