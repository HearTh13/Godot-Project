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
var alive

var init_pos 

var dialogue
var objective
var boss

var floor = []
var floorBlue = []
var floorRed = []

var doorOpen
var doorCol
var doorClose

var open = false
var open2 = false
var story2 = false
var story3 = false
var dialogueBox = false

var scene

func finish_change():
	if transition == true:
		transition = false
		floor = []
		floorBlue = []
		floorRed = []

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
	alive = true
	
	player_enter_posx = 276
	player_enter_posy = 154
	
	init_pos = true
	
	player_current_attack = false
	
	current_scene = "Dungeon1"
	transition = false
	paused = false
	message = 0
	
	dialogue = 1
	objective = "Selamatkan mereka!"
	
	boss = false

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
	file.store_var(boss)
	file.store_var(open)
	file.store_var(open2)
	file.store_var(story2)
	file.store_var(story3)

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
	boss = file.get_var()
	open = file.get_var()
	open2 = file.get_var()
	story2 = file.get_var()
	story3 = file.get_var()
