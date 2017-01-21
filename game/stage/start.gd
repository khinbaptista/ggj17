extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("button_down", self, "startRestart")
	pass

func startRestart():
	var sample_player = get_node("../SamplePlayer")
	var music = get_node("../Music")
	sample_player.play("ping")
	while sample_player.is_active():
		yield(get_tree(), "idle_frame")
	sample_player.play("microwave_starting")
	while sample_player.is_active():
		yield(get_tree(), "idle_frame")
	sample_player.play("microwave_noise")
	music.play("pipo")