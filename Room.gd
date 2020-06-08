extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const UP = Vector3(0, 1, 0)
const FRONT = Vector3(0, 0.6, -1)
const CAMERA_LOOK_EASING = 0.4
const CAMERA_POS_EASING = 0.5
const LIGHT_EASING = 0.9

var camera
var camera_original_position
var ball
var lights = []

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = $CameraLeft
	camera_original_position = camera.translation
	ball = $Table/Ball
	lights = $Spotlights.get_children()
	$Table/GoalLeft/ScoreDetector.connect("score_changed", self, "update_scoreboard")
	$Table/GoalRight/ScoreDetector.connect("score_changed", self, "update_scoreboard")
	
func update_scoreboard(_score):
	$ScoreBoard.text = str($Table/GoalLeft/ScoreDetector.score) + " - " + str($Table/GoalRight/ScoreDetector.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Menu.tscn")
	
	if Input.is_key_pressed(KEY_SPACE):
		$Table/Ball.reset()
		$Table/GoalLeft/ScoreDetector.score = 0
		$Table/GoalRight/ScoreDetector.score = 0

	var distance = ball.translation.length()
	camera.translation = Vector3(
		camera_original_position.x + ball.translation.x * CAMERA_POS_EASING,
		camera_original_position.y + distance * 0.5 * CAMERA_POS_EASING,
		camera_original_position.z + ball.translation.z * CAMERA_POS_EASING
		)
	camera.look_at(ball.translation * CAMERA_LOOK_EASING, FRONT)
	
	for light in lights:
		light.look_at((ball.translation + ball.linear_velocity * delta) * LIGHT_EASING, UP)
	
	
