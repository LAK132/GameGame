extends "res://nodeeditor/Node.gd"

func _ready():
	title = "Switch"
	add_socket(TYPE_BOOL, Color(0,0,1), true, "If")
	add_socket(TYPE_INT, Color(0,1,0), true, "True")
	add_socket(TYPE_INT, Color(0,1,0), true, "False")
	add_socket(TYPE_INT, Color(0,1,0), false, "Out")
	inputs[0].data = true
	inputs[1].data = 1
	inputs[2].data = 1
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
		if (inputs[0]):
			outputs[0].data = inputs[1].get_data()
		else:
			outputs[0].data = inputs[2].get_data()
		outputs[0].set_text(String(outputs[0].data))
		outputs[0].updated = true
		outputchanged = true
	print(get_instance_id())
	for o in outputs:
		print(o.data)
	return outputchanged