extends Spatial

onready var NodeEditor = get_node("NodeEditor")
onready var NodeEditorVis = get_node("NodeEditor/EditorContainer")
onready var menu = get_node("PopupMenu")
onready var buttonArea = get_node("Button/Spatial/MeshInstance/Area")
onready var openDoor = get_node("World/Door/OpenDoor")
onready var closeDoor = get_node("World/Door/ClosedDoor")
onready var openDoor2 = get_node("Door2/OpenDoor")
onready var closeDoor2 = get_node("Door2/ClosedDoor")

var within_button = false
var connected = false
var open = false

func _ready():
	NodeEditorVis.hide()
	closeDoor.show()
	closeDoor2.show()
	get_node("PopupMenu/Resume").connect("pressed", self, "_resume")
	get_node("PopupMenu/Quit").connect("pressed", self, "_quit")
	buttonArea.connect("area_entered", self, "_playerEnterButton")
	buttonArea.connect("area_exited", self, "_playerExitButton")
	NodeEditor.addWorldTrigger("Door", funcref(self, "_connected"))
	pass
	
func _resume():
	menu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _connected(door):
	if door == true:
		closeDoor.hide()
		openDoor.show()
		open = true
	else:
		open = false
		openDoor.hide()
		closeDoor.show()
	
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
			
	
	
	if open == true and within_button and Input.is_action_just_pressed("interact"):
		if closeDoor2.is_visible_in_tree():
			closeDoor2.hide()
			openDoor2.show()
		elif openDoor2.is_visible_in_tree():
			closeDoor2.show()
			openDoor2.hide()
			
	if Input.is_action_just_pressed("ui_tab"):
		if NodeEditorVis.is_visible_in_tree():
			NodeEditorVis.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			NodeEditorVis.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
