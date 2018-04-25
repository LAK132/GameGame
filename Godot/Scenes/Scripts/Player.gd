extends KinematicBody

#Constants
const GRAVITY = -18
const SPEED = 10
const JUMP = 9
const ACC = 3.5
const DEACC = 16
const SLOPE = 40
const SENSITIVITY = 0.05

#Variables
var camera
var camera_holder
var velocity = Vector3()

#Functions
func _ready():
	camera = $Rotation/Camera
	camera_holder = $Rotation

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var direction = Vector3()
	var cam_x = camera.get_global_transform()

	if Input.is_action_pressed("Forward"):
		direction += -cam_x.basis.z.normalized()
	if Input.is_action_pressed("Backward"):
		direction += cam_x.basis.z.normalized()
	if Input.is_action_pressed("Left"):
		direction += -cam_x.basis.x.normalized()
	if Input.is_action_pressed("Right"):
		direction += cam_x.basis.x.normalized()

	if is_on_floor():
		if Input.is_action_just_pressed("Jump"):
			velocity.y = JUMP

	direction.y = 0
	direction = direction.normalized()

	velocity.y += delta*GRAVITY

	var hvelocity = velocity
	hvelocity.y = 0

	var target = direction
	target *= SPEED

	var accel
	if direction.dot(hvelocity) > 0:
		accel = ACC
	else:
		accel = DEACC

	hvelocity = hvelocity.linear_interpolate(target, accel*delta)
	velocity.x = hvelocity.x
	velocity.z = hvelocity.z
	velocity = move_and_slide(velocity, Vector3(0,1,0), 0.05, 4, deg2rad(SLOPE))

func _input(event):
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_holder.rotate_x(deg2rad(event.relative.y * SENSITIVITY * -1))
		self.rotate_y(deg2rad(event.relative.x * SENSITIVITY * -1))

		var camera_rot = camera_holder.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		camera_holder.rotation_degrees = camera_rot


