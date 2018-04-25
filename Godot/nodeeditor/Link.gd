extends Node

#int, can get the actual resource from instance_from_id
var from
var to

func _ready():
	from = null
	to = null

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		# destruction of linked links is not handled by the engine
		# so we have to do it manually here
		remove_link()

func remove_link():
	if (from != null):
		from.linked = false
		from.link = null
	if (to != null):
		to.linked = false
		to.link = null


func init(from_socket, to_socket):
	from = from_socket
	from.link = self
	from.linked = true
	to = to_socket
	to.link = self
	to.linked = true