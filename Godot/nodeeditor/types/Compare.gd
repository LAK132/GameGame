extends "res://nodeeditor/Node.gd"

var menu = null
var menuSock = null
var popup = null

func _ready():
	menu = MenuButton.new()
	menu.flat = false
	menuSock = insert_child(0, TYPE_BOOL, menu)
	popup = menu.get_popup()
	popup.add_item(">", 0)
	popup.add_item("<", 1)
	popup.add_item("==", 2)
	popup.add_item("!=", 3)
	popup.connect("id_pressed", self, "_on_item_pressed")
	menu.text = popup.get_item_text(0)
	menuSock.data = 0

	title = "Compare"
	add_socket(TYPE_INT, Color(0,1,0), true, "A")
	add_socket(TYPE_INT, Color(0,1,0), true, "B")
	add_socket(TYPE_BOOL, Color(0,0,1), false, "O")
	inputs[1].data = 1
	inputs[2].data = 1
	poll(true)

func _on_item_pressed(ID):
	menu.text = popup.get_item_text(ID)
	menuSock.updated = true
	menuSock.data = ID
	menuSock.node.update()

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
		var inpa = inputs[1].get_data()
		if inpa == null:
			inpa = 0
		var inpb = inputs[2].get_data()
		if inpb == null:
			inpb = 1
		var mode = menuSock.data
		if mode == null:
			mode = 0
		if mode == 0:
			outputs[0].data = inpa > inpb
		elif mode == 1:
			outputs[0].data = inpa < inpb
		elif mode == 2:
			outputs[0].data = inpa == inpb
		elif mode == 3:
			outputs[0].data = inpa != inpb
		if outputs[0].data != true && outputs[0].data != false:
			outputs[0].data = false
		if outputs[0].data:
			outputs[0].set_text("True")
		else:
			outputs[0].set_text("False")
		outputs[0].updated = true
		outputchanged = true
	print(get_instance_id())
	for o in outputs:
		print(o.data)
	return outputchanged