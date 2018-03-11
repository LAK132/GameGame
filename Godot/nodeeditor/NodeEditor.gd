extends CanvasLayer

var graph_edit

func _ready():
	graph_edit = get_child(0)
	pass

func _on_AddNode_pressed():
	graph_edit.add_base()
	pass # replace with function body

func _on_DeleteNode_pressed():
	graph_edit.remove_selected()
	pass # replace with function body
