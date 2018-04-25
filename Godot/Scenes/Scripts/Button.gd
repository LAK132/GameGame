extends Spatial

var within_button = false

func _ready():
	get_node("MeshInstance/Area").connect("area_entered", self, "_player_enter")
	get_node("MeshInstance/Area").connect("area_exited", self, "_player_exit")
	set_process_input(true)
	pass

func _player_enter(body):
	within_button = true
	pass
	
func _player_exit(body):
	within_button = false
	pass
	
func _process(delta):
	if within_button:
		if Input.is_key_pressed(KEY_E):
			print("No Implementation Yet")
			#Insert Activate Code Code Here#
	
	pass
