extends Node

#onready var node1 = get_node("Camera/NodeEditor/GraphEdit")
#onready var node2 = get_node("Camera/NodeEditor/DeleteNode")
#onready var node3 = get_node("Camera/NodeEditor/AddNodeMenu")
onready var NodeEditor = get_node("Camera/NodeEditor/EditorContainer")

# class member variables go here, for example:
# var a = 2
# var b = \"textvar\"

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_tab"):
		if NodeEditor.is_visible_in_tree():
			NodeEditor.hide()
		else:
			NodeEditor.show()
	pass