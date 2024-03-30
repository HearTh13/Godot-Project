extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Yawning Sunlight.mp3")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Flashback1"
	$Player/CanvasLayer/GUI.visible = false
	Global.objective = "Belajar!"
	$Teacher.type = "teacher"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)
	
func change_scene():
	pass

func _on_progress_body_entered(body):
	if body.has_method("player"):
		Global.dialogue = 3
		get_tree().change_scene_to_file("res://Interface/dialogue_gui.tscn")

func _on_progress_body_exited(body):
	pass # Replace with function body.
