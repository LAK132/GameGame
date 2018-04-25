extends Node

onready var NodeEditor = get_node("Camera/NodeEditor")

func door_open(open):
	print("door open")
	pass

func _ready():
	NodeEditor.addWorldTrigger("Door", funcref(self, "door_open"))
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_tab"):
		if NodeEditor.is_visible_in_tree():
			NodeEditor.get.hide()
		else:
			NodeEditor.show()
	pass