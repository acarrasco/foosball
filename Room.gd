extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const UP = Vector3(0, 1, 0)
const CAMERA_EASING = 0.2
const LIGHT_EASING = 1

var cameras
var ball
var lights = []

# Called when the node enters the scene tree for the first time.
func _ready():
	cameras = [$CameraLeft]
	ball = $Table/Ball
	lights = [$SpotLight1, $SpotLight2, $SpotLight3, $SpotLight4]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		$Table/Ball.reset()
		$Table/GoalLeft/ScoreDetector.score = 0
		$Table/GoalRight/ScoreDetector.score = 0

	var target
	target = ball.translation * CAMERA_EASING
	for camera in cameras:
		camera.look_at(target, UP)
	
	target = ball.translation * LIGHT_EASING
	for light in lights:
		light.look_at(target, UP)
	
	$Score.text = str($Table/GoalLeft/ScoreDetector.score) + " - " + str($Table/GoalRight/ScoreDetector.score)
