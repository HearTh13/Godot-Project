extends Control

var dialogue
var pos
var chara
var text
var charA
var charB
var background
var itemBox
var item
var textSign
var animation

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation/ColorRect.visible = false
	
	animation = $Animation
	chara = $"Dialogue Box/Name"
	text = $"Dialogue Box/Text"
	charA = $CharacterA
	charB = $CharacterB
	background = $Background
	itemBox = $ItemBox
	item = $ItemBox/Item
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
			text.text = "Huft... Huft..."
		if pos == 1:
			chara.text = "Suhi"
			text.text = "Aku harus cepat sebelum dunia menjadi kacau...!"
		if pos == 2:
			background.texture = load("res://Assets/black.jpg")
			charA.texture = load("")
			chara.text = ""
			text.text = "..."
		if pos == 3:
			text.text = "3 jam yang lalu."
		if pos == 4:
			animation.play("fade_out_white")
	
	elif dialogue == 3:
		if pos == 0:
			background.texture = load("res://Assets/Background/classroom.jpg")
			charB.texture = load("")
			chara.text = "Pak Guru"
			text.text = "Baik! Seperti biasa, pelajaran akan dimulai. Buka bab 3 halaman 45!"
		if pos == 1:
			charA.texture = load("")
			charB.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "Suhi"
			text.text = "Hari yang membosankan seperti biasa..."
		if pos == 2:
			chara.text = "Suhi"
			text.text = "..."
		if pos == 3:
			charA.texture = load("res://Assets/SampleCharacter.png")
			charB.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "Murid A"
			text.text = "Grrrrr...!"
		if pos == 4:
			chara.text = "Pak Guru"
			text.text = "Paijo, kenapa kamu berdiri? Saya bilang pelajarannya akan dimulai!"
		if pos == 5:
			chara.text = "Murid A"
			text.text = "Grrrrr!!!"
		if pos == 6:
			charB.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "Suhi"
			text.text = "Si Paijo kenapa...?"
		if pos == 7:
			charA.texture = load("res://Assets/SampleCharacter.png")
			charB.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "Pak Guru"
			text.text = "Saya bilang, duduk!"
		if pos == 8:
			background.texture = load("res://Assets/Background/classroom.jpg")
			charA.texture = load("")
			charB.texture = load("")
			chara.text = "Murid A"
			text.text = "Graaaaaaah!"
		if pos == 9:
			Global.message = 0
			pos = 0
			Global.player_enter_posx = 585
			Global.player_enter_posy = 184
			get_tree().change_scene_to_file("res://Scene/Flashback2.tscn")
		
	elif dialogue == 4:
		if pos == 0:
			background.texture = load("res://Assets/Background/hallway.jpg")
			charB.texture = load("")
			chara.text = "Suhi"
			text.text = "Hah..! Hah...!"
		if pos == 1:
			chara.text = "Suhi"
			text.text = "Paijo! Apa yang kamu lakukan!?"
		if pos == 2:
			charA.texture = load("")
			charB.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "Murid A"
			text.text = "Groar!!!!"
		if pos == 3:
			charB.texture = load("")
			charA.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "Suhi"
			text.text = "Oh tidak, jalan buntu...!"
		if pos == 4:
			charA.texture = load("")
			chara.text = "???"
			text.text = "Jangan menyerah!"
		if pos == 5:
			charA.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "Suhi"
			text.text = "Huh?"
		if pos == 6:
			charA.texture = load("")
			chara.text = "???"
			text.text = "Gunakan Pedang ini!"
		if pos == 7:
			item.texture = load("res://Assets/katana.png")
			itemBox.visible = true
			chara.text = "???"
			text.text = "Pedang ini ampuh untuk melawan para Dream Eater!"
		if pos == 8:
			charA.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "Suhi"
			text.text = "... Dream Eater...!"
		if pos == 9:
			chara.text = "Suhi"
			text.text = "T-tapi jika aku menyerangnya-!"
		if pos == 10:
			charA.texture = load("")
			chara.text = "???"
			text.text = "Tenang saja! Temanmu tidak akan mati! Percaya saja!"
		if pos == 11:
			charA.texture = load("res://Assets/SampleCharacter.png")
			chara.text = "???"
			text.text = "B-baiklah kalau begitu!"
			
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


func _on_animation_animation_finished(anim_name):
	if anim_name == "fade_out_white":
		Global.dialogue = 0
		pos = 0
		Global.player_enter_posx = 80
		Global.player_enter_posy = 302
		get_tree().change_scene_to_file("res://Scene/Flashback1.tscn")
