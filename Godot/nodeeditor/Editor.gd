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

onready var node_res = preload("res://nodeeditor/GraphNode.tscn") # old nodes
onready var AddNode = preload("res://nodeeditor/types/Add.gd")

var selected_node = null

func _ready():
	pass

func remove_selected():
	print(selected_node)
	if(selected_node != null):
		#var connections = get_connection_list()
		#for con in connections:
			#if (con.to == selected_node || con.from == selected_node):
				#disconnect_node(con.from, con.from_port, con.to, con.to_port)
		remove_child(selected_node)
		selected_node = null

func slot_connected(node, port, right = false):
	var connections = get_connection_list()
	for con in connections:
		print(con)
		if ((right && con.from == node && con.from_port == port) ||
			(not right && con.to == node && con.to_port == port)):
				return con
	return null

func add_node(ID):
	var node = null
	match ID:
		0: #add
			node = AddNode.new()
		1: #subtract
			node = node_res.instance()
			node.new_subtract()
		2: #multiply
			node = node_res.instance()
			node.new_multiply()
		3: #divide
			node = node_res.instance()
			node.new_divide()
		4: #power
			node = node_res.instance()
			node.new_power()
		5: #switch
			node = node_res.instance()
			node.new_switch()
		_: #default
			node = node_res.instance()
			node.new_base()
	add_child(node)

func compile():
	pass
	#var connections = get_connection_list()
	#var nodes = Array()
	#for con in connections:
	#	if (not nodes.has(con.from)):
	#		nodes.append(con.from)
	#	if (not nodes.has(con.to)):
	#		nodes.append(con.to)
	#node_maker.make_graph(0, nodes.size(), connections.size())
	#for i in range(0, nodes.size()):
	#	node_maker.make_node(1, 1)
	#	#node_maker.poll_node(i)
	#for con in connections:
	#	node_maker.make_link(nodes.find(con.from), con.from_port, nodes.find(con.to), con.to_port)
	#node_maker.update_node(0)

func _on_GraphEdit_node_selected(node):
	selected_node = node
	print(node)

func _on_GraphEdit_delete_nodes_request():
	remove_selected()

func _on_GraphEdit_connection_request(from, from_port, to, to_port):
	print("connect req")
	if(from != to):
		var con = slot_connected(to, to_port)
		print(con)
		if(con != null):
			disconnect_node(con.from, con.from_port, con.to, con.to_port)
		connect_node(from, from_port, to, to_port)

func _on_GraphEdit_disconnection_request(from, from_port, to, to_port):
	print("disconnect req")
	disconnect_node(from, from_port, to, to_port)

func _on_GraphEdit_duplicate_nodes_request():
	print("duplicate req")
