extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ScoreDetector_body_entered(body):
	if body.has_method("reset"):
		score += 1
		body.reset()
