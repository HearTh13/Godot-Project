extends Control

var pos = 0

@onready var con = $Horizontal/Vertical/Continue
@onready var exit = $Horizontal/Vertical/Title

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Global.alive:
		$Horizontal/Vertical/Continue/Label.text = "Continue"
		$Objective/Label.text = Global.objective
		$Pause.text = "-- PAUSE --"
		$Dim.color = Color.from_hsv(0,0,0,0.5)
		
	elif !Global.alive:
		$Horizontal/Vertical/Continue/Label.text = "Retry"
		$Objective/Label.text = "Kamu kalah"
		$Pause.text = "-- GAME OVER --"
		$Dim.color = Color.from_hsv(0,0,0,1)
	
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
	if !Global.alive:
		Global.health = Global.max_health
		Global.mana = Global.max_mana
		get_tree().change_scene_to_file(Global.scene)
	else:
		Global.paused = false
		Engine.time_scale = 1
		self.visible = false

func _on_title_pressed():
	Global.paused = false
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Interface/menu.tscn")

func menu():
	if pos == 1:
		con.grab_focus()
		exit.release_focus()
	elif pos == 2:
		con.release_focus()
		exit.grab_focus()
