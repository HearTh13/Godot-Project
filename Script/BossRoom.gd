extends Node2D

func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Twinklerock Cave.ogg")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Dungeon6"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)

func change_scene():
	if Global.transition:
		pass
