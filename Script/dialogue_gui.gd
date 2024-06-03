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

var image :Image

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
			chara.text = "Suhi"
			text.text = "..."
		if pos == 3:
			charB.texture = load("res://Assets/character/kambing_hitam.png")
			chara.text = "Kambing Hitam"
			text.text = "Muahahaha!"
		if pos == 4:
			charA.texture = load("res://Assets/character/player_surprised.png")
			chara.text = "Suhi"
			text.text = "Kau...!"
		if pos == 5:
			chara.text = "Kambing Hitam"
			text.text = "Aku adalah Kambing Hitam. Simbol dari berbagai kejahatan!"
		if pos == 6:
			charA.texture = load("res://Assets/character/player_normal.png")
			chara.text = "Kambing Hitam"
			text.text = "Kalau kau ingin aku menghentikan semua ini... Kau harus melewati Puzzle yang sulitnya setengah mati dibalik pintu ini!"
		if pos == 7:
			chara.text = "Suhi"
			text.text = "OK."
		if pos == 8:
			charB.texture = load("res://Assets/character/kambing_hitam_angry.png")
			chara.text = "Kambing Hitam"
			text.text = "Jawabanmu hanya seperti itu?!"
		if pos == 9:
			chara.text = "Kambing Hitam"
			text.text = "Baiklah kalau begitu. Aku akan menunggumu ditempat terakhir!"
		if pos == 10:
			Global.dialogue = 0
			pos = 0
			Global.player_enter_posx = 36
			Global.player_enter_posy = 174
			get_tree().change_scene_to_file("res://Scene/Dungeon5.tscn")
	
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
	elif dialogue == 6:
		if pos == 0:
			background.texture = load("res://Assets/Background/cave.png")
			charA.texture = load("res://Assets/character/player_normal.png")
			charB.texture = load("")
			chara.text = "Suhi"
			text.text = "Inikah tempatnya...?"
		if pos == 1:
			chara.text = "Suhi"
			text.text = "Aku punya firasat buruk..."
		if pos == 2:
			charA.texture = load("")
			chara.text = "???"
			text.text = "Kalau aku jadi kau, aku tidak akan melangkah lebih jauh lagi."
		if pos == 3:
			charA.texture = load("res://Assets/character/player_normal.png")
			chara.text = "Suhi"
			text.text = "..."
		if pos == 4:
			charB.texture = load("res://Assets/character/kambing_hitam.png")
			chara.text = "Kambing Hitam"
			text.text = "Hahahahaha! Berani juga kau bisa sampai kesini!"
		if pos == 5:
			chara.text = "Suhi"
			text.text = "Bagaimana kalau kau sudahi saja semua ini?"
		if pos == 6:
			chara.text = "Kambing Hitam"
			text.text = "Kau pikir akan semudah itu?!"
		if pos == 7:
			chara.text = "Kambing Hitam"
			text.text = "Namaku adalah Kambing Hitam."
		if pos == 8:
			chara.text = "Kambing Hitam"
			text.text = "Aku adalah dalang dari semua ini. Aku adalah orang yang mengacaukan keseimbangan dunia nyata. Kukuku...!"
		if pos == 9:
			chara.text = "Suhi"
			text.text = "Kalau begitu aku hanya perlu mengalahkanmu kan?"
		if pos == 10:
			chara.text = "Kambing Hitam"
			text.text = "Mengalahkanku? Tidak semudah itu. Aku punya perwujudan yang lebih kuat!"
		if pos == 11:
			chara.text = "Kambing Hitam"
			text.text = "Aku akan mengalahkanmu dengan wujud ini!!!"
		if pos == 12:
			charB.texture = load("res://Assets/character/golem.png")
			chara.text = "Kambing Hitam"
			text.text = "Beep boop. Aku Golem."
		if pos == 13:
			chara.text = "Suhi"
			text.text = "Oh."
		if pos == 14:
			charB.texture = load("res://Assets/character/golem_angry.png")
			chara.text = "Kambing Hitam"
			text.text = "Kenapa kamu tidak terkejut!?"
		if pos == 15:
			chara.text = "Suhi"
			text.text = "Aku tidak perlu terkejut. Karena..."
		if pos == 16:
			charA.texture = load("")
			charB.texture = load("")
			background.texture = load("res://Assets/Background/cave_player.png")
			chara.text = "Suhi"
			text.text = "Kau akan kukalahkan sekarang juga!"
		if pos == 17:
			Global.message = 0
			pos = 0
			Global.player_enter_posx = 541
			Global.player_enter_posy = 185
			Global.current_scene = "BossRoom"
			get_tree().change_scene_to_file("res://Scene/BossRoom.tscn")
			
	elif dialogue == 7:
		if pos == 0:
			background.set_texture(load("res://Assets/Background/cave.png"))
			charA.set_texture(load("res://Assets/character/player_normal.png"))
			charB.texture = load("")
			chara.text = "Suhi"
			text.text = "Kau kalah...!"
		if pos == 1:
			charB.set_texture(load("res://Assets/character/kambing_hitam.png"))
			chara.text = "Kambing Hitam"
			text.text = "Ugh... Sial...!"
		if pos == 2:
			chara.text = "Suhi"
			text.text = "Beritahu aku, Kambing Hitam. Kenapa kau melakukan semua ini?"
		if pos == 3:
			chara.text = "Kambing Hitam"
			text.text = "Kurasa tidak ada gunanya menggunakan topeng ini lagi."
		if pos == 4:
			charB.set_texture(load("res://Assets/character/hero.png"))
			chara.text = "Kambing Hitam"
			text.text = "..."
		if pos == 5:
			charA.set_texture(load("res://Assets/character/player_surprised.png"))
			chara.text = "Suhi"
			text.text = "...Kau... Manusia...?"
		if pos == 6:
			charA.set_texture(load("res://Assets/character/player_normal.png"))
			chara.text = "Kambing Hitam"
			text.text = "Ya, benar."
		if pos == 7:
			charA.set_texture(load("res://Assets/character/player_hurt.png"))
			chara.text = "Suhi"
			text.text = "Tapi kenapa...?! Kenapa kau mau menghancurkan dunia nyata?!"
		if pos == 8:
			charA.set_texture(load("res://Assets/character/player_normal.png"))
			charB.set_texture(load("res://Assets/character/hero_2.png"))
			chara.text = "Kambing Hitam"
			text.text = "Itu karena... Mimpiku adalah menikahi tuan putri kerajaan ini."
		if pos == 9:
			charA.set_texture(load("res://Assets/character/player_surprised.png"))
			chara.text = "Suhi"
			text.text = "M-menikahi...?!"
		if pos == 10:
			charA.set_texture(load("res://Assets/character/player_normal.png"))
			chara.text = "Kambing Hitam"
			text.text = "Tapi mimpi itu sirna semenjak..."
		if pos == 11:
			charB.set_texture(load("res://Assets/character/hero_3.png"))
			chara.text = "Kambing Hitam"
			text.text = "Sang putri punya simpanan..."
		if pos == 12:
			charA.set_texture(load("res://Assets/character/player_funny.png"))
			chara.text = "Suhi"
			text.text = "A-Apa?!"
		if pos == 13:
			chara.text = "Kambing Hitam"
			text.text = "Padahal aku pernah hampir menyelamatkannya... Tetapi... Dia lebih memilih penyihir itu daripada diriku..."
		if pos == 14:
			charA.set_texture(load("res://Assets/character/player_hurt.png"))
			chara.text = "Suhi"
			text.text = "Dasar..."
		if pos == 14:
			charA.set_texture(load("res://Assets/character/player_hurt.png"))
			chara.text = "Suhi"
			text.text = "Itu permasalahan sepele, tahu!"
		if pos == 15:
			charA.set_texture(load("res://Assets/character/player_normal.png"))
			chara.text = "Kambing Hitam"
			text.text = "Tapi..."
		if pos == 16:
			chara.text = "Suhi"
			text.text = "Tidak ada tapi-tapian!"
		if pos == 17:
			chara.text = "Suhi"
			text.text = "Wanita di dunia ini banyak! Kenapa kau menyerah padahal kau masih bisa mendapatkan yang lain!"
		if pos == 18:
			charB.set_texture(load("res://Assets/character/hero_4.png"))
			chara.text = "Kambing Hitam"
			text.text = "..."
		if pos == 19:
			chara.text = "Suhi"
			text.text = "Ke-kenapa kau menatapku seperti itu?!"
		if pos == 20:
			chara.text = "Kambing Hitam"
			text.text = "Kau masih muda ya."
		if pos == 21:
			chara.text = "Suhi"
			text.text = "A-apa maksudmu?!"
		if pos == 22:
			chara.text = "Kambing Hitam"
			text.text = "Bukan apa-apa. Baiklah, aku mengakui. Kau menang. Aku akan mengembalikan dunia nyata seperti semula."
		if pos == 23:
			chara.text = "Kambing Hitam"
			text.text = "Tapi untuk kenang-kenangan..."
		if pos == 24:
			charB.set_texture(load("res://Assets/character/hero_5.png"))
			chara.text = "Kambing Hitam"
			text.text = "Aku minta cium dong."
		if pos == 25:
			charA.texture = load("")
			charB.texture = load("")
			chara.text = ""
			text.text = "Plak!"
		if pos == 26:
			charA.set_texture(load("res://Assets/character/player_happy.png"))
			charB.set_texture(load("res://Assets/character/hero_6.png"))
			chara.text = "Kambing Hitam"
			text.text = "...."
		if pos == 27:
			chara.text = "Kambing Hitam"
			text.text = "Kenangan seperti ini juga tidak masalah..."
		if pos == 28:
			charA.texture = load("")
			charB.texture = load("")
			chara.text = ""
			text.text = "-- Duniapun kembali damai --"
		if pos == 29:
			Global.message = 0
			pos = 0
			Global.player_enter_posx = 541
			Global.player_enter_posy = 185
			Global.current_scene = "BossRoom1"
			get_tree().change_scene_to_file("res://Interface/menu.tscn")
