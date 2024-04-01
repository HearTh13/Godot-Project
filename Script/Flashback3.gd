extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/BGM.stream = load("res://Assets/Music/Ursulian March.mp3")
	$Player.position.x = Global.player_enter_posx
	$Player.position.y = Global.player_enter_posy
	Global.current_scene = "Flashback3"
	Global.health = Global.max_health
	Global.mana = Global.max_mana
	$Player/CanvasLayer/GUI.visible = true
	Global.objective = "Lawan Paijo!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	Global.pause_menu($Player/CanvasLayer/PauseMenu)
	
func change_scene():
	if !self.has_node("Golem"):
		Global.dialogue = 5
		get_tree().change_scene_to_file("res://Interface/dialogue_gui.tscn")

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.dialogue = 4
		Global.message = 0
		get_tree().change_scene_to_file("res://Interface/dialogue_gui.tscn")

func _on_area_2d_body_exited(body):
	pass
