extends CanvasLayer

var graph_edit
var worldtrigger

func _ready():
	worldtrigger = Dictionary()
	graph_edit = get_node("EditorContainer/GraphEdit")

func addWorldTrigger(nam, trigger):
	worldtrigger[nam] = trigger

func _on_DeleteNode_pressed():
	graph_edit.remove_selected()

func _on_Compile_pressed():
	graph_edit.compile()
