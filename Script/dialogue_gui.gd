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
			charA.texture = load("res://Assets/character/player_hurt.png")
			charB.texture = load("")
			chara.text = "Suhi"
			text.text = "..."
		elif pos == 1:
			chara.text = "Suhi"
			text.text = "Kepalaku..."
		elif pos == 2:
			charA.texture = load("res://Assets/character/player_surprised.png")
			chara.text = "Suhi"
			text.text = "Eh...?"
		elif pos == 3:
			chara.text = "Suhi"
			text.text = "Aku masuk ke dunia mimpi?"
		elif pos == 4:
			charA.texture = load("res://Assets/character/player_hurt.png")
			chara.text = "Suhi"
			text.text = "Gh... Sekarang bukan waktunya untuk bimbang...!"
		elif pos == 5:
			charA.texture = load("res://Assets/character/player_normal.png")
			chara.text = "Suhi"
			text.text = "Aku harus menyelamatkan mereka!"
		elif pos == 6:
			Global.dialogue = 0
			pos = 0
			get_tree().change_scene_to_file("res://Scene/Dungeon1.tscn")
		
	elif dialogue == 2:
		if pos == 0:
			background.texture = load("res://Assets/Background/cave.png")
			charA.texture = load("res://Assets/character/player_normal.png")
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
			charA.texture = load("res://Assets/character/teacher_normal.png")
			charB.texture = load("")
			chara.text = "Pak Guru"
			text.text = "Baik! Seperti biasa, pelajaran akan dimulai. Buka bab 3 halaman 45!"
		if pos == 1:
			charA.texture = load("")
			charB.texture = load("res://Assets/character/player_normal.png")
			chara.text = "Suhi"
			text.text = "Hari yang membosankan seperti biasa..."
		if pos == 2:
			chara.text = "Suhi"
			text.text = "..."
		if pos == 3:
			charA.texture = load("res://Assets/character/teacher_normal.png")
			charB.texture = load("res://Assets/character/studentA_angry.png")
			chara.text = "Murid A"
			text.text = "Grrrrr...!"
		if pos == 4:
			charA.texture = load("res://Assets/character/teacher_normal.png")
			chara.text = "Pak Guru"
			text.text = "Paijo, kenapa kamu berdiri? Saya bilang pelajarannya akan dimulai!"
		if pos == 5:
			chara.text = "Murid A"
			text.text = "Grrrrr!!!"
		if pos == 6:
			charB.texture = load("res://Assets/character/player_surprised.png")
			chara.text = "Suhi"
			text.text = "Si Paijo kenapa...?"
		if pos == 7:
			charA.texture = load("res://Assets/character/teacher_angry.png")
			charB.texture = load("res://Assets/character/studentA_angry.png")
			chara.text = "Pak Guru"
			text.text = "Saya bilang, duduk!"
		if pos == 8:
			background.texture = load("res://Assets/red.jpg")
			charA.texture = load("")
			charB.texture = load("")
			chara.text = ""
			text.text = "*Slash*"
		if pos == 9:
			background.texture = load("res://Assets/Background/classroom.jpg")
			charB.texture = load("res://Assets/character/studentA_angry.png")
			chara.text = "Murid A"
			text.text = "Graaaaaaah!"
		if pos == 10:
			charA.texture = load("res://Assets/character/studentB_normal.png")
			charB.texture = load("")
			chara.text = "Murid B"
			text.text = "P-Paijo berubah menjadi monster!!"
		if pos == 11:
			chara.text = "Murid B"
			text.text = "Kyaaa! Lari semuanya!!"
		if pos == 12:
			Global.message = 0
			pos = 0
			Global.player_enter_posx = 585
			Global.player_enter_posy = 184
			get_tree().change_scene_to_file("res://Scene/Flashback2.tscn")
		
	elif dialogue == 4:
		if pos == 0:
			background.texture = load("res://Assets/Background/hallway.jpg")
			charA.texture = load("res://Assets/character/player_normal.png")
			charB.texture = load("")
			chara.text = "Suhi"
			text.text = "Hah..! Hah...!"
		if pos == 1:
			chara.text = "Suhi"
			text.text = "Paijo! Apa yang kamu lakukan!?"
		if pos == 2:
			charA.texture = load("")
			charB.texture = load("res://Assets/character/studentA_angry.png")
			chara.text = "Murid A"
			text.text = "Groar!!!!"
		if pos == 3:
			charB.texture = load("")
			charA.texture = load("res://Assets/character/player_surprised.png")
			chara.text = "Suhi"
			text.text = "Oh tidak, jalan buntu...!"
		if pos == 4:
			charA.texture = load("")
			chara.text = "???"
			text.text = "Jangan menyerah!"
		if pos == 5:
			charA.texture = load("res://Assets/character/player_surprised.png")
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
			charA.texture = load("res://Assets/character/player_normal.png")
			chara.text = "Suhi"
			text.text = "... Dream Eater...!"
		if pos == 9:
			itemBox.visible = false
			charA.texture = load("res://Assets/character/player_hurt.png")
			chara.text = "Suhi"
			text.text = "T-tapi jika aku menyerangnya-!"
		if pos == 10:
			charA.texture = load("")
			chara.text = "???"
			text.text = "Tenang saja! Temanmu tidak akan mati! Percaya saja!"
		if pos == 11:
			charA.texture = load("res://Assets/character/player_normal.png")
			chara.text = "???"
			text.text = "B-baiklah kalau begitu!"
		if pos == 12:
			Global.message = 0
			pos = 0
			Global.player_enter_posx = 113
			Global.player_enter_posy = 201
			get_tree().change_scene_to_file("res://Scene/Flashback3.tscn")
	
	elif dialogue == 5:
		if pos == 0:
			background.texture = load("res://Assets/Background/hallway.jpg")
			charA.texture = load("res://Assets/character/player_normal.png")
			charB.texture = load("")
			chara.text = "Suhi"
			text.text = "Hah..! Hah...!"
		if pos == 1:
			charA.texture = load("res://Assets/character/player_crying.png")
			chara.text = "Suhi"
			text.text = "A-aku membunuh Paijo...!"
		if pos == 2:
			chara.text = "Suhi"
			text.text = "Hei! Keluarlah dan jelaskan apa yang terjadi!"
		if pos == 3:
			charA.texture = load("")
			chara.text = "???"
			text.text = "Sebentar! Aku juga harus keluar dari sini."
		if pos == 4:
			chara.text = "???"
			text.text = "Duh, sempit!"
		if pos == 5:
			background.texture = load("res://Assets/Background/portal.jpg")
			chara.text = ""
			text.text = "*Zwush*"
		if pos == 6:
			background.texture = load("res://Assets/Background/hallway.jpg")
			charA.texture = load("res://Assets/character/player_surprised.png")
			charB.texture = load("res://Assets/character/starfruit_normal.png")
			chara.text = "???"
			text.text = "Hi."
		if pos == 7:
			chara.text = "Suhi"
			text.text = "M-m-m-makhluk apa kau!?"
		if pos == 8:
			charB.texture = load("res://Assets/character/starfruit_funny.png")
			chara.text = "Starfruit"
			text.text = "Aku Starfruit si Belimbing."
		if pos == 9:
			charB.texture = load("res://Assets/character/starfruit_angry.png")
			chara.text = "Starfruit"
			text.text = "Tapi itu tidak penting sekarang. Yang terpenting sekarang adalah menyelamatkan Dunia dari Kambing Hitam!"
		if pos == 10:
			chara.text = "Suhi"
			text.text = "K-kambing Hitam...?"
		if pos == 11:
			chara.text = "Starfruit"
			text.text = "Kambing Hitam adalah Makhluk yang sangat berbahaya. Dia bisa memakan mimpi seseorang jika orang tersebut sudah meninggalkan mimpinya."
		if pos == 12:
			charA.texture = load("res://Assets/character/player_normal.png")
			chara.text = "Suhi"
			text.text = "Maksudnya?"
		if pos == 13:
			chara.text = "Starfruit"
			text.text = "Singkatnya orang-orang akan mengamuk dan berperang satu sama lain."
		if pos == 14:
			charA.texture = load("res://Assets/character/player_surprised.png")
			chara.text = "Suhi"
			text.text = "Seperti Paijo?!"
		if pos == 15:
			charA.texture = load("res://Assets/character/player_crying.png")
			chara.text = "Suhi"
			text.text = "Hei, apa ada cara untuk menyelamatkan dunia?"
		if pos == 16:
			chara.text = "Starfruit"
			text.text = "Ada, tapi kamu harus menghadapi Kambing Hitam. Itu satu-satunya cara."
		if pos == 17:
			charA.texture = load("res://Assets/character/player_hurt.png")
			chara.text = "Suhi"
			text.text = "A-apa aku bisa?"
		if pos == 18:
			charB.texture = load("res://Assets/character/starfruit_normal.png")
			chara.text = "Starfruit"
			text.text = "Percaya dirilah. Kalau kamu tidak percaya diri mulai dari sekarang, sampai kapanpun kamu tidak akan pernah bisa menjadi orang hebat."
		if pos == 19:
			charA.texture = load("res://Assets/character/player_normal.png")
			chara.text = "Suhi"
			text.text = "Baiklah kalau begitu."
		if pos == 20:
			chara.text = "Starfruit"
			text.text = "Baiklah, akan kubuka kembali portalnya. Kita akan pergi ke mimpi yang hilang untuk mengalahkan Kambing Hitam. Apa kamu siap?"
		if pos == 21:
			background.texture = load("res://Assets/Background/portal.jpg")
			chara.text = "Suhi"
			text.text = "Siap!"
		if pos == 22:
			chara.text = "Starfruit"
			text.text = "Kalau begitu, ayo!"
		if pos == 23:
			animation.play("fade_out_white")

func _on_animation_animation_finished(anim_name):
	if anim_name == "fade_out_white":
		if Global.dialogue == 2:
			Global.dialogue = 0
			pos = 0
			Global.player_enter_posx = 80
			Global.player_enter_posy = 302
			get_tree().change_scene_to_file("res://Scene/Flashback1.tscn")
		if Global.dialogue == 5:
			Global.dialogue = 0
			pos = 0
			Global.player_enter_posx = 36
			Global.player_enter_posy = 174
			get_tree().change_scene_to_file("res://Scene/Dungeon5.tscn")
