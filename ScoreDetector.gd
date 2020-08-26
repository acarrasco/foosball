extends Area

signal score_changed(score)

export var score: int = 0 setget _set_score

func _set_score(new_score: int) -> void:
	score = new_score
	emit_signal("score_changed", score)

func _on_ScoreDetector_body_entered(body: Ball):
	if body:
		_set_score(score + 1)
		body.reset()
