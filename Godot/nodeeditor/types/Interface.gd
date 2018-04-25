extends "res://nodeeditor/Node.gd"

var menu = null
var menuSock = null
var popup = null

func _ready():
	menu = MenuButton.new()
	menu.flat = false
	menuSock = insert_child(0, TYPE_INT, menu)
	popup = menu.get_popup()
	popup.add_item("Add", 0)
	popup.add_item("Subtract", 1)
	popup.add_item("Multiply", 2)
	popup.add_item("Divide", 3)
	popup.add_item("Switch", 4)
	popup.add_item("Interface", 5)
	popup.connect("id_pressed", self, "_on_item_pressed")
	menu.text = popup.get_item_text(0)

	title = "Interface"
	add_input(TYPE_INT, Color(0,1,0), "A")
	add_input(TYPE_INT, Color(0,1,0), "B")
	add_output(TYPE_INT, Color(0,1,0), "A+B")
	inputs[0].data = 1
	inputs[1].data = 1
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
		#outputs[0].data =
		var inpt = inputs[0].get_data()
		if inpt == null:
			inpt = inputs[1].get_data() + inputs[2].get_data()
		outputs[0].data = inpt
		outputs[0].set_text(String(outputs[0].data))
		outputs[0].updated = true
		outputchanged = true
	print(get_instance_id())
	for o in outputs:
		print(o.data)
	return outputchanged