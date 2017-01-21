extends Node

func _ready():
	# Pause
	get_tree().set_pause(true)
	
	# Hide kernels
	var kernels = get_node("corns").get_children()
	for kernel in kernels:
		kernel.set_hidden(true)
	
	get_node("menu/popcorn").connect("microwave_start", self, "on_start")

func on_start():
	# Unpause
	get_tree().set_pause(false)
	
	# Reveal kernels
	var kernels = get_node("corns").get_children()
	for kernel in kernels:
		kernel.set_hidden(false)
	
	# Start display
	get_node("display").start_display()
	
	# Hide other elements
	get_node("menu/quit/door").hide()
	get_node("menu/Sprite").hide()
	
	# Disable buttons
	get_node("menu/popcorn").set_disabled(true)
	get_node("menu/credits").set_disabled(true)
	
	get_node("player_corn").connect("popped", self, "on_game_over")
	
func on_game_over():
	# Pause
	get_tree().set_pause(true)
	
	# Enable buttons
	get_node("menu/popcorn").set_disabled(false)
	get_node("menu/credits").set_disabled(false)
	
	# Reload kernels
	get_node("corns").queue_free()
	var nodes_res = preload("res://corn/corn_collection.tscn")
	var node_collection = nodes_res.instance()
	node_collection.set_name("corns")
	add_child(node_collection)
	
	get_node("player_corn").queue_free()
	call_deferred("add_child", load("res://corn/player_corn.tscn").instance())
	
	# Reveal other elements
	get_node("menu/quit/door").show()
	get_node("menu/Sprite").show()
