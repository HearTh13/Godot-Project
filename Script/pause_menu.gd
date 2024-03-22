extends Control

var pos = 0

@onready var con = $Horizontal/Vertical/Continue
@onready var exit = $Horizontal/Vertical/Title

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Objective/Label.text = Global.objective
	if Input.is_action_just_pressed("Down"):
		pos += 1
		if pos > 2:
			pos = 1
	if Input.is_action_just_pressed("Up"):
		pos -= 1
		if pos < 1:
			pos = 2
	menu()

func _on_continue_pressed():
	Global.paused = false
	Engine.time_scale = 1
	self.visible = false

func _on_title_pressed():
	Global.paused = false
	get_tree().change_scene_to_file("res://Interface/menu.tscn")

func menu():
	if pos == 1:
		con.grab_focus()
		exit.release_focus()
	elif pos == 2:
		con.release_focus()
		exit.grab_focus()
