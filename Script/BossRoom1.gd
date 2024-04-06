extends Node2D

func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Call of War.ogg")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Dungeon6"
	$Player/CanvasLayer/GUI.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)

func change_scene():
	if Global.transition:
		if Global.current_scene == "Dungeon6":
			get_tree().change_scene_to_file("res://Scene/Dungeon6.tscn")

func _on_dungeon_6_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon6"
		Global.transition = true
		Global.player_enter_posx = 541
		Global.player_enter_posy = 185
