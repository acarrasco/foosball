extends Area

signal score_changed(score)

export var score = 0 setget _set_score

func _set_score(new_score):
	score = new_score
	emit_signal("score_changed", score)

func _on_ScoreDetector_body_entered(body):
	if body.has_method("reset"):
		_set_score(score + 1)
		body.reset()
