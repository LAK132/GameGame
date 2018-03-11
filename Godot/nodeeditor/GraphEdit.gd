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

var node_res = preload("res://nodeeditor/GraphNode.tscn")
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

func add_base():
	var node = node_res.instance()
	node.new_base()
	add_child(node)

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
