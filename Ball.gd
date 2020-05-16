extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const NUDGE_LIMIT = 5
const NUDGE_SPEED = 4

const BOTTOM_LIMIT = -100
const MAX_STRENGTH = 200

var previous_velocity = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func nudge():
	var v = Vector2(linear_velocity.x, linear_velocity.z).length()
	if (v < NUDGE_LIMIT):
		var x = NUDGE_SPEED * (randf() - 0.5)
		var z = NUDGE_SPEED * (randf() - 0.5)
		apply_central_impulse(Vector3(x, 0, z))

func reset():
	translation = Vector3(0, 10, 0)
	linear_velocity = Vector3(0, 0, 0)
	nudge()

func _ready():
	nudge()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	previous_velocity = linear_velocity
	if translation.y < BOTTOM_LIMIT:
		reset()

	if (Input.is_joy_button_pressed(0, JOY_L3) or
		Input.is_joy_button_pressed(0, JOY_R3) or
		Input.is_joy_button_pressed(1, JOY_L3) or
		Input.is_joy_button_pressed(1, JOY_R3)):
		nudge()

	if Input.get_mouse_button_mask() & 1:
		var viewport = get_viewport()
		var camera = viewport.get_camera()
		var mouse_position = viewport.get_mouse_position()
		var field_plane = Plane(0, 1, 0, 0)
		var target = field_plane.intersects_ray(
			camera.project_ray_origin(mouse_position),
			camera.project_ray_normal(mouse_position)
		)
		apply_central_impulse(delta * (target - translation))


func _on_Ball_body_entered(body):
	var strength = min((linear_velocity - previous_velocity).length(), MAX_STRENGTH)
	if strength > 15:
		$AudioStreamPlayer3D.unit_db = log(strength)
		$AudioStreamPlayer3D.pitch_scale = 0.7 + 0.3 * (strength / MAX_STRENGTH)
		$AudioStreamPlayer3D.play()
