extends Node

export var joy = 0
export var invert = false
export var team_color = Color.azure

var left_analog_bar = 0
var right_analog_bar = 0

var bars = []
var just_dpad_pressed = false
var just_shoulder_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if invert:
		bars = [$"3", $"2", $"1", $"0"]
	else:
		bars = [$"0", $"1", $"2", $"3"]
	
	
	var material = SpatialMaterial.new()
	material.albedo_color = team_color
	
	for bar in bars:
		for child in bar.get_children():
			if child is KinematicBody:

				child.get_node("Mesh").set_surface_material(0, material)



func switch_bar(index, just_pressed, direction_left, direction_right, analog):
	if Input.is_joy_button_pressed(joy, direction_left):
		if not just_pressed:
			bars[index].active = false
			index = max(index - 1, 0)
			bars[index].active = true
			bars[index].analog = analog
		just_pressed = true
	elif Input.is_joy_button_pressed(joy, direction_right):
		if not just_pressed:
			bars[index].active = false
			index = min(index + 1, len(bars)-1)
			bars[index].active = true
			bars[index].analog = analog
		just_pressed = true
	else:
		just_pressed = false
	return [index, just_pressed]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var result
	
	result = switch_bar(left_analog_bar, just_dpad_pressed, JOY_DPAD_LEFT, JOY_DPAD_RIGHT, 0)
	left_analog_bar = result[0]
	just_dpad_pressed = result[1]
	
	result  = switch_bar(right_analog_bar, just_shoulder_pressed, JOY_BUTTON_4, JOY_BUTTON_5, 1)
	right_analog_bar = result[0]
	just_shoulder_pressed = result[1]
		
