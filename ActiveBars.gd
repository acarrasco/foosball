extends Node

export var joy = 0
export var invert = false
export var team_color = Color.azure

var left_analog_bar = 0
var right_analog_bar = 0

var bars = []
var just_pressed_dpad = false
var just_pressed_shoulder = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if invert:
		bars = [$"3", $"2", $"1", $"0"]
	else:
		bars = [$"0", $"1", $"2", $"3"]
	assign_team_color()

func assign_team_color():
	var material = SpatialMaterial.new()
	material.albedo_color = team_color
	material.roughness = 0.2
	
	for bar in bars:
		for child in bar.get_children():
			if child is KinematicBody:
				child.get_node("Mesh").set_surface_material(0, material)	

func switch_bar(index, just_pressed, direction_left, direction_right, analog):
	var change = 0
	var new_index = index
	if Input.is_joy_button_pressed(joy, direction_left):
		if not just_pressed:
			change = -1
		just_pressed = true
	elif Input.is_joy_button_pressed(joy, direction_right):
		if not just_pressed:
			change = 1
		just_pressed = true
	else:
		just_pressed = false
	
	if change != 0:
		new_index = clamp(index + change, 0, len(bars)-1)
		bars[index].deactivate()
		bars[new_index].activate(analog)
	
	return [new_index, just_pressed]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var result
	
	result = switch_bar(left_analog_bar, just_pressed_dpad, JOY_DPAD_LEFT, JOY_DPAD_RIGHT, 0)
	left_analog_bar = result[0]
	just_pressed_dpad = result[1]
	
	result  = switch_bar(right_analog_bar, just_pressed_shoulder, JOY_BUTTON_4, JOY_BUTTON_5, 1)
	right_analog_bar = result[0]
	just_pressed_shoulder = result[1]
		
