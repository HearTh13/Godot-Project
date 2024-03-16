extends Node2D

func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Twinklerock Cave.ogg")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)

func _on_dungeon_1_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon1"
		Global.transition = true
		Global.player_enter_posx = 321
		Global.player_enter_posy = 35

func _on_dungeon_1_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false

func _on_dungeon_3_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon3"
		Global.transition = true
		Global.player_enter_posx = 24
		Global.player_enter_posy = 186

func _on_dungeon_3_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false

func change_scene():
	if Global.transition:
		if Global.current_scene == "Dungeon1":
			get_tree().change_scene_to_file("res://Scene/Dungeon1.tscn")
			Global.finish_change()
		if Global.current_scene == "Dungeon3":
			get_tree().change_scene_to_file("res://Scene/Dungeon3.tscn")
			Global.finish_change()


