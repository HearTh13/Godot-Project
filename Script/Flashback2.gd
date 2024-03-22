extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Ursulian March.mp3")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	$Player/CanvasLayer/GUI.visible = false
	Global.objective = "Kalahkan Paijo!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)
	
func change_scene():
	pass
