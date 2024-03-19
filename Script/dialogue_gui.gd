extends Control

var dialogue
var pos
var chara
var text
var charA
var charB
var background
var itemBox
var textSign

# Called when the node enters the scene tree for the first time.
func _ready():
	chara = $"Dialogue Box/Name"
	text = $"Dialogue Box/Text"
	charA = $CharacterA
	charB = $CharacterB
	background = $Background
	itemBox = $ItemBox
	pos = 0
	dialogue = Global.dialogue
	textSign = Global.message
	print(dialogue)
	print(textSign)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dialog()
	if Input.is_action_just_pressed("Attack-OK"):
		pos += 1

func dialog():
	if dialogue == 1:
		if pos == 0:
			background.texture = load("res://Assets/Background/cave.png")
			charB.texture = load("")
			chara.text = "Suhi"
			text.text = "..."
		elif pos == 1:
			chara.text = "Suhi"
			text.text = "Kepalaku..."
		elif pos == 2:
			chara.text = "Suhi"
			text.text = "Eh...?"
		elif pos == 3:
			chara.text = "Suhi"
			text.text = "Aku masuk ke dunia mimpi?"
		elif pos == 4:
			chara.text = "Suhi"
			text.text = "Gh... Sekarang bukan waktunya untuk bimbang...!"
		elif pos == 5:
			chara.text = "Suhi"
			text.text = "Aku harus menyelamatkan mereka!"
		elif pos == 6:
			Global.dialogue = 0
			pos = 0
			get_tree().change_scene_to_file("res://Scene/Dungeon1.tscn")
		
	elif dialogue == 2:
		if pos == 0:
			background.texture = load("res://Assets/Background/cave.png")
			charB.texture = load("")
			chara.text = "Suhi"
			text.text = "Aku harus cepat sebelum yang lain...!"
		if pos == 1:
			Global.dialogue = 0
			pos = 0
			Global.player_enter_posx = 80
			Global.player_enter_posy = 302
			get_tree().change_scene_to_file("res://Scene/Flashback1.tscn")

	elif textSign == 1:
		if pos == 0:
			background.texture = load("res://Assets/Background/cave.png")
			charB.texture = load("")
			charA.texture = load("")
			chara.text = "Papan Tutorial"
			text.text = "WASD dan Arrow Key untuk jalan, Spasi dan Enter untuk menyerang"
		if pos == 1:
			chara.text = "Papan Tutorial"
			text.text = "Tekan Shift dan berjalan untuk lari"
		if pos == 2:
			Global.message = 0
			pos = 0
			get_tree().change_scene_to_file("res://Scene/Dungeon1.tscn")
