extends GraphNode

var _curr_index = 0

func _ready():
	pass

func add_slot(text, type, left, color):
	set_slot(_curr_index, left, type, color, not left, type, color)
	_curr_index+=1
	var label = Button.new()
	var btn = Label.new()
	btn.add_child(label)
	label.set_text(text)
	if left:
		label.align = HALIGN_LEFT
	else:
		label.align = HALIGN_RIGHT
	add_child(btn)
	pass

func new_base():
	title = "Base"
	add_slot("val", 0, true, Color(1.0,1.0,1.0))
	add_slot("val", 0, true, Color(1.0,1.0,1.0))
	add_slot("val", 0, true, Color(1.0,1.0,1.0))
	pass

func new_subtract():
	title = "Subtract"
	add_slot("A", 0, true, Color(1,1,1))
	add_slot("B", 0, true, Color(1,1,1))
	add_slot("-", 0, false, Color(1,1,1))

func new_multiply():
	title = "Multiply"
	add_slot("A", 0, true, Color(1,1,1))
	add_slot("B", 0, true, Color(1,1,1))
	add_slot("*", 0, false, Color(1,1,1))

func new_divide():
	title = "Divide"
	add_slot("A", 0, true, Color(1,1,1))
	add_slot("B", 0, true, Color(1,1,1))
	add_slot("/", 0, false, Color(1,1,1))

func new_power():
	title = "Power"
	add_slot("A", 0, true, Color(1,1,1))
	add_slot("B", 0, true, Color(1,1,1))
	add_slot("^", 0, false, Color(1,1,1))

func new_switch():
	title = "Switch"
	add_slot("A or B?", 0, true, Color(0.2,0.2,1))
	add_slot("A", 0, true, Color(1,1,1))
	add_slot("B", 0, true, Color(1,1,1))
	add_slot("out", 0, false, Color(1,1,1))