extends CanvasLayer

var graph_edit

func _ready():
	graph_edit = get_child(0)

func _on_DeleteNode_pressed():
	graph_edit.remove_selected()

func _on_Compile_pressed():
	graph_edit.compile()
