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
	Global.current_scene = "Dungeon6"
	$Player/CanvasLayer/GUI.visible = true
	
	doorClose = $Door/Closed
	doorOpen = $Door/Open
	doorCol = $Door/Collision
	doorCol2 = $Door/Collision2
	doorCol3 = $Door/Collision3
	
	if Global.story4:
		$Area2D/Collision.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)
	if Global.open2:
		doorOpen.visible = true
		doorClose.visible = false
		doorCol.disabled = true
		doorCol2.disabled = false
		doorCol3.disabled = false
		$Message2/CollisionShape2D.disabled = true
		
func _on_dungeon_5_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon5"
		Global.transition = true
		Global.player_enter_posx = 611
		Global.player_enter_posy = 166

func _on_dungeon_5_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false

func _on_boss_room_transfer_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "BossRoom1"
		Global.transition = true
		Global.player_enter_posx = 541
		Global.player_enter_posy = 185

func change_scene():
	if Global.transition:
		if Global.current_scene == "Dungeon5":
			get_tree().change_scene_to_file("res://Scene/Dungeon5.tscn")
		if Global.current_scene == "BossRoom1":
			get_tree().change_scene_to_file("res://Scene/BossRoom1.tscn")
		if Global.current_scene == "Dungeon7":
			get_tree().change_scene_to_file("res://Scene/Dungeon7.tscn")

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.dialogue = 6
		Global.message = 0
		get_tree().change_scene_to_file("res://Interface/dialogue_gui.tscn")

func _on_dungeon_7_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Dungeon7"
		Global.transition = true
		Global.player_enter_posx = 34
		Global.player_enter_posy = 143
