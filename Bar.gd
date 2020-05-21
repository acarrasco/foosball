extends KinematicBody

export var max_sway = 15
export var sway_speed = 100

export var max_rotation = deg2rad(90)
export var rotation_speed = 4 * deg2rad(360)
export var minimum_sway = 0.1

export var SWAY_AXIS = [JOY_ANALOG_LY, JOY_ANALOG_RY]
export var ROTATE_AXIS = [JOY_ANALOG_LX, JOY_ANALOG_RX]

export var invert = 1

export var joy = 0
export var analog = -1

var sway = 0
var rotate = 0

export var inactive_material: SpatialMaterial = SpatialMaterial.new()
export var active_material_analog_0: SpatialMaterial = SpatialMaterial.new()
export var active_material_analog_1: SpatialMaterial = SpatialMaterial.new()

var active_materials
var hands

# Called when the node enters the scene tree for the first time.
func _ready():
	$CSGCylinder.material = inactive_material
	active_materials = [active_material_analog_0, active_material_analog_1]
	if invert == -1:
		hands = [$RightHand, $LeftHand]
	else:
		hands = [$LeftHand, $RightHand]

func activate(_analog):
	analog = _analog
	$CSGCylinder.material = active_materials[_analog]
	for hand in hands:
		hand.visible = false
	hands[analog].visible = true

func deactivate()	:
	analog = -1
	$CSGCylinder.material = inactive_material
	for hand in hands:
		hand.visible = false

func move(delta):
	var sway_input = invert * Input.get_joy_axis(joy, SWAY_AXIS[analog])
	if abs(sway_input) < minimum_sway:
		sway_input = 0
	var sway_target = clamp(sway + sway_input * delta * sway_speed, -max_sway, max_sway)
	var sway_diff = sway_target - sway
	sway = sway_target
	translate(Vector3(0, 0, sway_diff))

func spin(delta):
	var rotate_input = invert * Input.get_joy_axis(joy, ROTATE_AXIS[analog])
	var rotate_target = rotate_input * max_rotation
	var rotate_diff = (rotate_target - rotate) * delta * rotation_speed
	rotate += rotate_diff
	rotate_z(rotate_diff)

func _process(delta):
	if analog < 0:
		return
	move(delta)
	spin(delta)
