extends Control

var pos = 0
var fading = false
@onready var play = $MenuButton/CenterRow/Buttons/Play
@onready var con = $MenuButton/CenterRow/Buttons/Continue
@onready var exit = $MenuButton/CenterRow/Buttons/Exit

func _process(delta):
	if fading:
		$MainMusic.volume_db -= 0.5
	if !$MainMusic.playing:
		$MainMusic.play()
	if Input.is_action_just_pressed("Down"):
		pos += 1
		if pos == 4:
			pos = 1
	elif Input.is_action_just_pressed("Up"):
		pos -= 1
		if pos == 0:
			pos = 3
	menu()

func _on_play_pressed():
	$ButtonPressedSFX.play(1)
	fading = true
	$Animation.play("fade")

func _on_continue_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
	
func menu():
	if pos == 1:
		play.grab_focus()
		con.release_focus()
		exit.release_focus()
	elif pos == 2:
		con.grab_focus()
		play.release_focus()
		exit.release_focus()
	elif pos == 3:
		exit.grab_focus()
		con.release_focus()
		play.release_focus()

func _on_animation_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://Interface/dialogue_gui.tscn")
