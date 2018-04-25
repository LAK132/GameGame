extends "res://nodeeditor/Node.gd"

var menu = null
var menuSock = null
var popup = null
onready var nodeeditor = get_node("../../../")
var trigger = null

func _ready():
	menu = MenuButton.new()
	menu.flat = false
	menuSock = insert_child(0, TYPE_INT, menu)
	popup = menu.get_popup()

	var i = 0
	for k in nodeeditor.worldtrigger.keys():
		popup.add_item(k, i)
		i = i + 1

	popup.connect("id_pressed", self, "_on_item_pressed")
	menu.text = popup.get_item_text(0)

	title = "Interface"
	add_input(TYPE_BOOL, Color(0,0,1), "A")
	inputs[1].data = false
	poll(true)

func _on_item_pressed(ID):
	menu.text = popup.get_item_text(ID)
	menuSock.updated = true
	menuSock.data = ID
	if nodeeditor.worldtrigger.has(popup.get_item_text(ID)):
		trigger = nodeeditor.worldtrigger[popup.get_item_text(ID)]
	else:
		trigger = null
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
		var inpt = inputs[1].get_data()
		outputchanged = true
		if trigger != null:
			trigger.call_func(inpt == true)
	print(get_instance_id())
	for o in outputs:
		print(o.data)
	return outputchanged