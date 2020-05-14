extends Area

export var score = 0

func _ready():
	pass # Replace with function body.

func _on_ScoreDetector_body_entered(body):
	if body.has_method("reset"):
		score += 1
		body.reset()
