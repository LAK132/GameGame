# WARNING: the code that follows will make you cry; a safety pig is provided below for your benefit.
#
#  _._ _..._ .-',     _.._(`))
# '-. `     '  /-._.-'    ',/
#    )         \            '.
#   / _    _    |             \
#  |  a    a    /              |
#  \   .-.                     ;
#   '-('' ).-'       ,'       ;
#      '-;           |      .'
#         \           \    /
#         | 7  .__  _.-\   \
#         | |  |  ``/  /`  /
#        /,_|  |   /,_/   /
#           /,_/      '`-'

extends GraphEdit

onready var AddNode = preload("res://nodeeditor/types/Add.gd")
onready var SubNode = preload("res://nodeeditor/types/Subtract.gd")
onready var MulNode = preload("res://nodeeditor/types/Multiply.gd")
onready var DivNode = preload("res://nodeeditor/types/Divide.gd")
onready var SwtNode = preload("res://nodeeditor/types/Switch.gd")

onready var link_res = preload("res://nodeeditor/Link.gd")

var nodes
var links
var selected_node = null

func _ready():
	nodes = Array()
	links = Array()

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		pass

func _on_GraphEdit_node_selected(node):
	selected_node = node
	print(node)

func _on_GraphEdit_delete_nodes_request():
	print("delete req")
	remove_selected()

func _on_GraphEdit_connection_request(from, from_port, to, to_port):
	print("connect req")
	add_link(from, from_port, to, to_port)

func _on_GraphEdit_disconnection_request(from, from_port, to, to_port):
	print("disconnect req")
	remove_link(from, from_port, to, to_port)

func _on_GraphEdit_duplicate_nodes_request():
	print("duplicate req")

func add_node(ID):
	var node = null
	match ID:
		0: #add
			node = AddNode.new()
		1: #subtract
			node = SubNode.new()
		2: #multiply
			node = MulNode.new()
		3: #divide
			node = DivNode.new()
		4: #switch
			node = SwtNode.new()
	if (node != null):
		node.init(self)
		nodes.append(node)
		add_child(node)

func remove_selected():
	for n in nodes:
		if (n.selected):
			for con in get_connection_list():
				if (n.name == con.to || n.name == con.from):
					remove_link(con.from, con.from_port, con.to, con.to_port)
			nodes.erase(n)
			remove_child(n)
			n.queue_free()

func add_link(from, from_port, to, to_port):
	if (from == to):
		return
	var to_node = find_node(to, false, false)
	var to_socket = to_node.inputs[to_port]
	if (to_socket.linked):
		for con in get_connection_list():
			if (con.to == to):
					remove_link(con.from, con.from_port, con.to, con.to_port)
	var from_node = find_node(from, false, false)
	var from_socket = from_node.outputs[from_port]
	var link = link_res.new()
	link.init(from_socket, to_socket)
	links.append(link)
	connect_node(from, from_port, to, to_port)
	to_node.update(true)

func remove_link(from, from_port, to, to_port):
	var from_node = find_node(from, false, false)
	var from_socket = from_node.outputs[from_port]
	var to_node = find_node(to, false, false)
	var to_socket = to_node.inputs[to_port]
	for link in links:
		if (link.from == from_socket && link.to == to_socket):
			links.erase(link)
			link.queue_free()
	disconnect_node(from, from_port, to, to_port)

func update(force = false):
	for n in nodes:
		n.updated = n.updated && !force
		n.update()