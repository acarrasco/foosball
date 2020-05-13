extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_sway = 15
export var sway_speed = 100

export var max_rotation = deg2rad(90)
export var rotation_speed = 4 * deg2rad(360)

export var SWAY_AXIS = [JOY_ANALOG_LY, JOY_ANALOG_RY]
export var ROTATE_AXIS = [JOY_ANALOG_LX, JOY_ANALOG_RX]

export var invert = 1

export var joy = 0
export var analog = 0

export var active = false

var sway = 0
var rotate = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active:
		return
	var sway_input = invert * Input.get_joy_axis(joy, SWAY_AXIS[analog])
	var sway_target = clamp(sway + sway_input * delta * sway_speed, -max_sway, max_sway)
	var sway_diff = sway_target - sway
	sway = sway_target
	translate(Vector3(0, 0, sway_diff))
	
	var rotate_input = invert * Input.get_joy_axis(joy, ROTATE_AXIS[analog])
	var rotate_target = rotate_input * max_rotation
	var rotate_diff = (rotate_target - rotate) * delta * rotation_speed
	rotate += rotate_diff
	rotate_z(rotate_diff)
