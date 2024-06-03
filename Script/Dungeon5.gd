extends Node2D

var doorClose
var doorOpen
var doorCol

func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Lost in Pixels.mp3")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Dungeon5"
	$Player/CanvasLayer/GUI.visible = false
	
	Global.floor = []
	Global.floorBlue = []
	Global.floorRed = []
	
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
	
	doorClose = $Door/Closed
	doorOpen = $Door/Open
	doorCol = $Door/Collision
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)
	if Global.open:
		doorOpen.visible = true
		doorClose.visible = false
		doorCol.disabled = true
		
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
		if Global.current_scene == "Dungeon6":
			get_tree().change_scene_to_file("res://Scene/Dungeon6.tscn")
