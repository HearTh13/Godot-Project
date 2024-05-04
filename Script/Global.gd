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
var money 
var alive

var init_pos 

var dialogue
var objective
var boss

var floor = []
var floorBlue = []
var floorRed = []

var open = false
var open2 = false
var story2 = false
var story3 = false
var story4 = false
var dialogueBox = false

var scene

var inventory = []
var equip = null

signal inventory_updated

var player_node: Node = null
@onready var inventory_slot_scene = preload("res://Interface/inventory_slot.tscn")

func pause_menu(dim):
	if !player_node.inDialogueBox:
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
	str = 50
	def = 10
	next = 10
	exp = 0
	money = 50
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
	inventory = []
	equip = null
	
	open = false
	open2 = false
	story2 = false
	story3 = false
	story4 = false
	dialogueBox = false
	
	inventory.resize(10)

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
	file.store_var(money)
	file.store_var(init_pos)
	file.store_var(dialogue)
	file.store_var(objective)
	file.store_var(inventory)
	file.store_var(equip)
	file.store_var(boss)
	file.store_var(open)
	file.store_var(open2)
	file.store_var(story2)
	file.store_var(story3)
	file.store_var(story4)
	file.store_var(alive)

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
	money = file.get_var()
	init_pos = file.get_var()
	dialogue = file.get_var()
	objective = file.get_var()
	inventory = file.get_var()
	equip = file.get_var()
	boss = file.get_var()
	open = file.get_var()
	open2 = file.get_var()
	story2 = file.get_var()
	story3 = file.get_var()
	story4 = file.get_var()
	alive = file.get_var()

func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null && inventory[i]["name"] == item["name"]:
			print("lol")
			inventory[i]["quantity"] += item["quantity"]
			return true
		elif inventory[i] == null:
			inventory[i] = item
			return true
	return false

func remove_item(item):
	for i in inventory.size():
		if inventory[i] != null:
			if inventory[i]["type"] == item["type"] && inventory[i]["effect"] == item["effect"]:
				inventory[i]["quantity"] -= 1
				if inventory[i]["quantity"] == 0:
					inventory[i] = null
			return true
	return false

func set_player_reference(player):
	player_node = player
	
