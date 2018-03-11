extends KinematicBody

var speed = 5
var direction = Vector3()
var view = 0.3
var yaw = 0
var pitch = 0

func _input(ie):
	#Camera Rotation Towards Cursor#
	if ie.is_class("InputEventMouseMotion"):
		yaw = fmod(yaw - ie.relative.x * view, 360)
		pitch = max(min(pitch - ie.relative.y * view, 90), -90)
		get_node("Yaw").set_rotation(Vector3(0, deg2rad(yaw),0))
		get_node("Yaw/Camera").set_rotation(Vector3(deg2rad(pitch),deg2rad(yaw),0))
	pass

func _ready():
	set_physics_process(true)
	set_process_input(true)
	pass
	
func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	#Camera Movement Towards Cursor#
	var dir = get_node("Yaw/Camera").get_global_transform().basis
	direction = Vector3(0, 0, 0)
	if Input.is_key_pressed(KEY_A):
		direction -= dir[0]
	if Input.is_key_pressed(KEY_D):
		direction += dir[0]
	if Input.is_key_pressed(KEY_W):
		direction -= dir[2]
	if Input.is_key_pressed(KEY_S):
		direction += dir[2]
	direction.y = 0
	if Input.is_key_pressed(KEY_SPACE):
		direction += Vector3(0,1,0)
	direction = direction.normalized()
	
	
	
	move_and_slide(direction * speed, Vector3(0, 1, 0))
	pass