extends Node

func _ready():
	get_tree().paused = true
	$TitleScreen.room = $Room
