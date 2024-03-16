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
	dialogue = 0
	pos = 0
	textSign = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dialogue = Global.dialogue
	textSign = Global.message
	dialog()
	if Input.is_action_just_pressed("Attack-OK"):
		pos += 1

func dialog():
	if dialogue == 1:
		if pos == 0:
			background.texture = load("res://Assets/Background/cave.png")
			charB.texture = load("")
			chara.text = "Suzy"
			text.text = "..."
		elif pos == 1:
			chara.text = "Suzy"
			text.text = "Kepalaku..."
		elif pos == 2:
			chara.text = "Suzy"
			text.text = "Eh...?"
		elif pos == 3:
			chara.text = "Suzy"
			text.text = "Aku masuk ke dunia mimpi?"
		elif pos == 4:
			chara.text = "Suzy"
			text.text = "Gh... Sekarang bukan waktunya untuk bimbang...!"
		elif pos == 5:
			chara.text = "Suzy"
			text.text = "Aku harus menyelamatkan mereka!"
		elif pos == 6:
			Global.dialogue = 0
			pos = 0
			get_tree().change_scene_to_file("res://Scene/Dungeon1.tscn")

	elif textSign == "1":
		if pos == 0:
			background.texture = load("res://Assets/Background/cave.png")
			charB.texture = load("")
			charA.texture = load("")
			chara.text = "Tanda"
			text.text = "Selamat datang di Dream Diver. Tempat dimana mimpi menjadi kenyataan!"
		if pos == 1:
			pos = 0
			get_tree().change_scene_to_file("res://Scene/Dungeon1.tscn")
