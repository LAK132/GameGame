extends GraphNode

var _curr_index = 0

func _ready():
	pass

func add_slot(text, type, left, right, color):
	set_slot(_curr_index, left, type, color, right, type, color)
	_curr_index+=1
	var node = Label.new()
	node.set_text(text)
	add_child(node)
	pass

func new_base():
	add_slot("val", 0, true, true, Color(1.0,1.0,1.0))
	add_slot("val", 0, true, true, Color(1.0,1.0,1.0))
	add_slot("val", 0, true, true, Color(1.0,1.0,1.0))
	pass