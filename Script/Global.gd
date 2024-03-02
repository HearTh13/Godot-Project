extends Node

var player_current_attack = false

var current_scene
var transition = false

var player_enter_posx = 276
var player_enter_posy = 154

var init_pos = true

func finish_change():
	if transition == true:
		transition = false
		if current_scene == "Dungeon1":
			current_scene = "Dungeon2"
			
		if current_scene == "Dungeon2":
			current_scene = "Dungeon1"
