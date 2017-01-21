extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("button_down", self, "quit")
	pass

func quit():
	get_node("../SamplePlayer").play("ping")
	get_tree().quit()