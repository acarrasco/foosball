extends Control

var room: Room = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/NewGameButton.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		self.visible = not self.visible
		get_tree().paused = not get_tree().paused

func _on_QuitButton_pressed():
	get_tree().quit(0)

func _on_NewGameButton_pressed():
	self.visible = false
	room.reset()
	get_tree().paused = false
