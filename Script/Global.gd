extends Node

var player_current_attack

var current_scene 
var transition 
var paused 
var message 

var player_enter_posx 
var player_enter_posy 

var level 
var max_health 
var health 
var max_mana 
var mana 
var str 
var def 
var next 
var exp 

var init_pos 

var dialogue
var objective

func finish_change():
	if transition == true:
		transition = false
		if current_scene == "Dungeon1":
			current_scene = "Dungeon2-1"
		if current_scene == "Dungeon2-1":
			current_scene = "Dungeon1"
		if current_scene == "Dungeon2-2":
			current_scene = "Dungeon3"
		if current_scene == "Dungeon3":
			current_scene = "Dungeon2-1"

func pause_menu(dim):
	if Input.is_action_just_pressed("Pause"):
		if paused:
			Engine.time_scale = 1
			dim.visible = false
		else:
			Engine.time_scale = 0
			dim.visible = true
		paused = !paused

func initial():
	level = 1
	max_health = 50
	health = max_health
	max_mana = 20
	mana = max_mana
	str = 20
	def = 10
	next = 10
	exp = 0
	
	player_enter_posx = 276
	player_enter_posy = 154
	
	init_pos = true
	
	player_current_attack = false
	
	current_scene = "Dungeon1"
	transition = false
	paused = false
	message = 0
	
	dialogue = 1
	objective = "Cari jalan keluar!"

func save_game():
	var file = FileAccess.open("user://SaveData.dat", FileAccess.WRITE)
	file.store_var(current_scene)
	file.store_var(transition)
	file.store_var(paused)
	file.store_var(message)
	file.store_var(player_enter_posx)
	file.store_var(player_enter_posy)
	file.store_var(level)
	file.store_var(max_health)
	file.store_var(health)
	file.store_var(max_mana)
	file.store_var(mana)
	file.store_var(str)
	file.store_var(def)
	file.store_var(next)
	file.store_var(exp)
	file.store_var(init_pos)
	file.store_var(dialogue)
	file.store_var(objective)

func load_game():
	var file = FileAccess.open("user://SaveData.dat", FileAccess.READ)
	current_scene = file.get_var()
	transition = file.get_var()
	paused = file.get_var()
	message = file.get_var()
	player_enter_posx = file.get_var()
	player_enter_posy = file.get_var()
	level = file.get_var()
	max_health = file.get_var()
	health = file.get_var()
	max_mana = file.get_var()
	mana = file.get_var()
	str = file.get_var()
	def = file.get_var()
	next = file.get_var()
	exp = file.get_var()
	init_pos = file.get_var()
	dialogue = file.get_var()
	objective = file.get_var()
