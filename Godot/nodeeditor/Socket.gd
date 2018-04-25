extends Label

var link_res = preload("res://nodeeditor/Link.gd")

var type
var color

var node = null
var link = null
var input = null
var linked = false
var updated = false

var data = null

func _ready():
	pass

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		# destruction of linked links is not handled by the engine
		# so we have to do it manually here
		# node.nodetree.remove_link(link)
		if (linked):
			link.remove_link()

func init(ty, n, isIn, text):
	type = ty
	node = n
	input = isIn
	set_text(text)
	if (isIn):
		align = HALIGN_LEFT
	else:
		align = HALIGN_RIGHT

func add_link(other_socket):
	if(input == other_socket.input):
		return
	link = link_res.new()
	if(input):
		link.init(other_socket, self)
	else:
		link.init(self, other_socket)

func get_data():
	if (linked):
		if (input):
			return link.from.data
	return data