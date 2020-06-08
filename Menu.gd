extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/VBoxContainer/NewGameButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		# return to game
		pass

func _on_QuitButton_pressed():
	get_tree().quit(0)

func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Room.tscn")
