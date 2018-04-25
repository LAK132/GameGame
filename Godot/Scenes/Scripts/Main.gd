extends Spatial

onready var menu = get_node("PopupMenu")

func _ready():
	get_node("PopupMenu/Resume").connect("pressed", self, "_resume")
	get_node("PopupMenu/Quit").connect("pressed", self, "_quit")
	pass
	
func _resume():
	menu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _quit():
	get_tree().quit()
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_menu"):
		if menu.is_visible_in_tree():
			menu.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			menu.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
