extends Node

var player_current_attack = false

var current_scene
var transition = false
var paused = false

var player_enter_posx = 276
var player_enter_posy = 154

var max_health = 160
var health = max_health
var max_mana = 100
var mana = max_mana
var str = 20
var def = 10

var init_pos = true

func finish_change():
	if transition == true:
		transition = false
		if current_scene == "Dungeon1":
			current_scene = "Dungeon2"
			
		if current_scene == "Dungeon2":
			current_scene = "Dungeon1"

func pause_menu(menu):
	if Input.is_action_just_pressed("Pause"):
		if paused:
			menu.hide()
			Engine.time_scale = 1
		else:
			menu.show()
			Engine.time_scale = 0
		paused = !paused
