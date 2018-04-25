extends Node

onready var NodeEditor = get_node("Camera/NodeEditor/EditorContainer")

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_tab"):
		if NodeEditor.is_visible_in_tree():
			NodeEditor.hide()
		else:
			NodeEditor.show()
	pass