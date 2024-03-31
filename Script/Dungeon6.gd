extends Node2D

func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Twinklerock Cave.ogg")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Dungeon3"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	camera_limit()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)
		
func _on_dungeon_2_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon2"
		Global.transition = true
		Global.player_enter_posx = 618
		Global.player_enter_posy = 95
		
func _on_dungeon_2_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false
		
func _on_dungeon_4_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon4"
		Global.transition = true
		Global.player_enter_posx = 24
		Global.player_enter_posy = 186

func _on_dungeon_4_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false

func change_scene():
	if Global.transition:
		if Global.current_scene == "Dungeon2":
			get_tree().change_scene_to_file("res://Scene/Dungeon2.tscn")
			Global.finish_change()
		if Global.current_scene == "Dungeon4":
			get_tree().change_scene_to_file("res://Scene/Dungeon4.tscn")
			Global.finish_change()

func camera_limit():
	$Player/Camera.limit_right = 1408
	$Player/Camera.limit_bottom = 1312
