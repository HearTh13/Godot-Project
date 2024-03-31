extends Node2D

func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Twinklerock Cave.ogg")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Dungeon5"
	
	Global.floor.append($"Color Floor1")
	Global.floorBlue.append($"Color Floor1/Blue")
	Global.floorRed.append($"Color Floor1/Red")
	$"Color Floor1/Label".text = "1"
	
	Global.floor.append($"Color Floor2")
	Global.floorBlue.append($"Color Floor2/Blue")
	Global.floorRed.append($"Color Floor2/Red")
	$"Color Floor2/Label".text = "2"
	
	Global.floor.append($"Color Floor3")
	Global.floorBlue.append($"Color Floor3/Blue")
	Global.floorRed.append($"Color Floor3/Red")
	$"Color Floor3/Label".text = "3"
	
	Global.floor.append($"Color Floor4")
	Global.floorBlue.append($"Color Floor4/Blue")
	Global.floorRed.append($"Color Floor4/Red")
	$"Color Floor4/Label".text = "4"
	
	Global.doorClose = $Door/Closed
	Global.doorOpen = $Door/Open
	Global.doorCol = $Door/Collision
	
	if Global.open:
		Global.doorOpen.visible = true
		Global.doorClose.visible = false
		Global.doorCol.shape = null
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	camera_limit()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)
		
func _on_dungeon_4_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon4"
		Global.transition = true
		Global.player_enter_posx = 618
		Global.player_enter_posy = 250

func _on_dungeon_4_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false

func _on_dungeon_6_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon6"
		Global.transition = true
		Global.player_enter_posx = 36
		Global.player_enter_posy = 174
	
func _on_dungeon_6_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false

func change_scene():
	if Global.transition:
		if Global.current_scene == "Dungeon4":
			get_tree().change_scene_to_file("res://Scene/Dungeon4.tscn")
			Global.finish_change()
		if Global.current_scene == "Dungeon6":
			get_tree().change_scene_to_file("res://Scene/Dungeon6.tscn")
			Global.finish_change()

func camera_limit():
	$Player/Camera.limit_right = 640
	$Player/Camera.limit_bottom = 310
