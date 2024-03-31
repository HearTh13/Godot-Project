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
	
	doorClose = $Door/Closed
	doorOpen = $Door/Open
	doorCol = $Door/Collision
	doorCol2 = $Door/Collision2
	doorCol3 = $Door/Collision3

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
		Global.player_enter_posx = 24
		Global.player_enter_posy = 186

func _on_dungeon_5_transfer_body_exited(body):
	if body.has_method("player"):
		Global.transition = false

func change_scene():
	if Global.transition:
		if Global.current_scene == "Dungeon5":
			get_tree().change_scene_to_file("res://Scene/Dungeon5.tscn")
			Global.finish_change()
