extends Spatial

onready var menu = get_node("PopupMenu")
onready var buttonArea = get_node("Button/Spatial/MeshInstance/Area")
onready var openDoor = get_node("World/Door/OpenDoor")
onready var closeDoor = get_node("World/Door/ClosedDoor")

var within_button = false

func _ready():
	closeDoor.show()
	get_node("PopupMenu/Resume").connect("pressed", self, "_resume")
	get_node("PopupMenu/Quit").connect("pressed", self, "_quit")
	buttonArea.connect("area_entered", self, "_playerEnterButton")
	buttonArea.connect("area_exited", self, "_playerExitButton")
	pass
	
func _resume():
	menu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _quit():
	get_tree().quit()
	pass
	
func _playerEnterButton(body):
	within_button = true
	pass
	
func _playerExitButton(body):
	within_button = false
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_menu"):
		if menu.is_visible_in_tree():
			menu.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			menu.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if within_button and Input.is_key_pressed(KEY_E):
		if closeDoor.is_visible_in_tree():
			closeDoor.hide()
			openDoor.show()
	pass
