extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("button_down", self, "credits")
	pass

func credits():
	get_node("../SamplePlayer").play("ping")
	var creditsimg = get_node("../credits 2")
	if(creditsimg.is_visible()):
		creditsimg.hide()
	else:
		creditsimg.show()