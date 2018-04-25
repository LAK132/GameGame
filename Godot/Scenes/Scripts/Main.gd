extends Spatial

onready var menu = get_node("PopupMenu")
onready var buttonArea = get_node("Button/Spatial/MeshInstance/Area")
onready var openDoor = get_node("World/Door/OpenDoor")
onready var closeDoor = get_node("World/Door/ClosedDoor")

var within_button = false

onready var NodeEditor = get_node("NodeEditor")

func door_open(open):
	if open:
		closeDoor.hide()
		openDoor.show()
	else:
		closeDoor.show()
		openDoor.hide()

func _ready():
	NodeEditor.addWorldTrigger("Door", funcref(self, "door_open"))
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
		var editorcont = NodeEditor.get_node("EditorContainer")
		if editorcont.is_visible_in_tree():
			editorcont.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			editorcont.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("ui_tab"):
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
