extends Node2D

var doorClose
var doorOpen
var doorCol
var doorCol2
var doorCol3

func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Twinklerock Cave.ogg")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Dungeon7"
	$Player/CanvasLayer/GUI.visible = false
	
	doorClose = $Door/Closed
	doorOpen = $Door/Open
	doorCol = $Door/Collision

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)
	if Global.story4:
		doorOpen.visible = true
		doorClose.visible = false
		doorCol.disabled = true

func change_scene():
	if Global.transition:
		if Global.current_scene == "Dungeon6":
			get_tree().change_scene_to_file("res://Scene/Dungeon6.tscn")

func _on_dungeon_6_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon6"
		Global.transition = true
		Global.player_enter_posx = 1366
		Global.player_enter_posy = 1179
