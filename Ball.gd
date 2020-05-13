extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const NUDGE_LIMIT = 4

# Called when the node enters the scene tree for the first time.
func nudge():
	var v = Vector2(linear_velocity.x, linear_velocity.z).length()
	if (v < NUDGE_LIMIT):
		var x = 2 * randf() - 1
		var z = 2 * randf() - 1
		apply_central_impulse(Vector3(x, 0, z))
	


func _ready():
	nudge()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_joy_button_pressed(0, JOY_L3) or
		Input.is_joy_button_pressed(0, JOY_R3) or
		Input.is_joy_button_pressed(1, JOY_L3) or
		Input.is_joy_button_pressed(1, JOY_R3)):
		nudge()
