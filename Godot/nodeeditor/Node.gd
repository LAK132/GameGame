extends GraphNode

var socket_res = preload("res://nodeeditor/Socket.gd")

var nodetree
var inputs
var outputs
var updated

var slot_count = 0

func _ready():
	inputs = Array()
	outputs = Array()

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		pass

func init(nt):
	nodetree = nt

func insert_slot(index, type, color, isIn, obj, hasSocket = true):
	for i in range(slot_count, index):
		set_slot(i, is_slot_enabled_left(i), get_slot_type_left(i), get_slot_color_left(i),
					  is_slot_enabled_right(i), get_slot_type_right(i), get_slot_color_right(i))
	slot_count+=1
	#if hasSocket:
	set_slot(index, isIn, type, color, !isIn, type, color)
	#else:
	#	set_slot(index, false, type, color, true, type, color)
	add_child(obj)
	move_child(obj, index)

func insert_child(index, type, obj):
	var sock = socket_res.new()
	sock.init(type, self, true, "")
	sock.add_child(obj)
	inputs.insert(index, sock)
	insert_slot(index, type, Color(0,0,0), true, sock, false)
	return sock

func insert_socket(index, type, color, isIn, text = "Val"):
	var sock = socket_res.new()
	sock.init(type, self, isIn, text)
	if (isIn):
		inputs.insert(index, sock)
	else:
		outputs.insert(index-inputs.size(), sock)
	insert_slot(index, type, color, isIn, sock)
	return sock

func add_socket(type, color, isIn, text = "Val"):
	var index = inputs.size() + outputs.size()
	return insert_socket(slot_count, type, color, isIn, text)

func add_input(type, color, text = "Val"):
	var index = inputs.size() + outputs.size()
	return insert_socket(slot_count, type, color, true, text)

func add_output(type, color, text = "Val"):
	var index = inputs.size() + outputs.size()
	return insert_socket(slot_count, type, color, false, text)

func poll():
	return false

func update(force = false):
	# check dependencies
	var inputchanged = false
	if (!updated): # prevent parent nodes from polling this node again
		updated = true
		for i in inputs:
			if (i.linked):
				i.link.from.node.update()
				inputchanged = inputchanged || i.link.from.updated
			else:
				inputchanged = inputchanged || i.updated
	# cascade
	var outputchanged = false
	if (inputchanged || force): # if input updated
		if (poll(force)): # if output updated
			outputchanged = true
			for o in outputs:
				if (o.linked && o.updated):
					o.link.to.node.update()
	updated = false
	return outputchanged