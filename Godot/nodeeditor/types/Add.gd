extends "res://nodeeditor/Node.gd"

func _ready():
	title = "Add"
	add_socket(TYPE_INT, Color(0,1,0), true, "A")
	add_socket(TYPE_INT, Color(0,1,0), true, "B")
	add_socket(TYPE_INT, Color(0,1,0), false, "A+B")
	inputs[0].data = 1
	inputs[1].data = 1
	poll(true)

func poll(force = false):
	for o in outputs:
		o.updated = false
	var inputchanged = false
	for i in inputs:
		if i.linked:
			inputchanged = inputchanged || i.link.from.updated
		else:
			inputchanged = inputchanged || i.updated
		if (inputchanged):
			pass
	var outputchanged = false
	if (inputchanged || force): # recalculate outputs
		outputs[0].data = inputs[0].get_data() + inputs[1].get_data()
		outputs[0].set_text(String(outputs[0].data))
		outputs[0].updated = true
		outputchanged = true
	print(get_instance_id())
	for o in outputs:
		print(o.data)
	return outputchanged