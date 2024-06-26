extends CharacterBody2D
#
var enemy = null
var signBoard = null
var floor = null
var character = null

var enemy_inattack_range = false
var enemy_attack_cooldown = true

var current_dir = "Walk_Front"
var player_state = "idle"

const speed = 125

var attack_ip = false
var save_state = false
var inDialogueBox = false

var pos = 0

func _ready():
	Global.set_player_reference(self)
	Global.player_current_attack = false
	Global.scene = "res://Scene/"+Global.current_scene+".tscn"
	$Animation/Dim.visible = false
	$Projectile.visible = false
	$CollisionProjectileArea/CollisionProjectile.disabled = true

func _physics_process(_delta):
	if !$CanvasLayer/PauseMenu.visible:
		play_bgm()
		if !Global.paused or !Global.dialogueBox or Global.alive:
			player_movement()
			enemy_attack()
			save()
			current_camera()
			update_health()
		
			if Global.health <= 0:
				Global.alive = false
				Global.health = 0
				get_tree().change_scene_to_file("res://Interface/pause_menu.tscn")
		
		if inDialogueBox:
			chat()
	
	if Input.is_action_just_pressed("Skill 1"):
		Global.skill = 0
	elif Input.is_action_just_pressed("Skill 2"):
		Global.skill = 1
	elif Input.is_action_just_pressed("Skill 3"):
		Global.skill = 2
	
	if Global.skill == 0:
		$CanvasLayer/HBoxContainer/SkillBox1/Equip.visible = true
		$CanvasLayer/HBoxContainer/SkillBox2/Equip.visible = false
		$CanvasLayer/HBoxContainer/SkillBox3/Equip.visible = false
	elif Global.skill == 1:
		$CanvasLayer/HBoxContainer/SkillBox1/Equip.visible = false
		$CanvasLayer/HBoxContainer/SkillBox2/Equip.visible = true
		$CanvasLayer/HBoxContainer/SkillBox3/Equip.visible = false
	elif Global.skill == 2:
		$CanvasLayer/HBoxContainer/SkillBox1/Equip.visible = false
		$CanvasLayer/HBoxContainer/SkillBox2/Equip.visible = false
		$CanvasLayer/HBoxContainer/SkillBox3/Equip.visible = true
	
	if Input.is_action_just_pressed("Projectile"):
		if Global.equip[Global.skill] != null:
			$RegenTime.stop()
			if Global.equip[Global.skill]["effect"] == "Lightning Damage":
				if Global.mana >= 3:
					Global.mana -= 3
					if current_dir == "Walk_Side":
						if $AnimatedSprite2D.flip_h:
							$Animation.play("lightning_right")
						if !$AnimatedSprite2D.flip_h:
							$Animation.play("lightning_left")
					if current_dir == "Walk_Back":
						$Animation.play("lightning_up")
					if current_dir == "Walk_Front":
						$Animation.play("lightning_down")
			if Global.equip[Global.skill]["effect"] == "Explosive Damage":
				if Global.mana >= 3:
					Global.mana -= 3
					$Animation.play("Explosion")
			if Global.equip[Global.skill]["effect"] == "Fire Breath":
				if Global.mana >= 3:
					Global.mana -= 3
					if current_dir == "Walk_Side":
						if $AnimatedSprite2D.flip_h:
							$Animation.play("fire_breath_right")
						if !$AnimatedSprite2D.flip_h:
							$Animation.play("fire_breath_left")
					if current_dir == "Walk_Back":
						$Animation.play("fire_breath_up")
					if current_dir == "Walk_Front":
						$Animation.play("fire_breath_down")
			if Global.equip[Global.skill]["effect"] == "Unleash Glacier":
				if Global.mana >= 6:
					Global.mana -= 6
					$Animation.play("ice_glacier")
			if Global.equip[Global.skill]["effect"] == "Heal HP":
				if Global.mana >= 6:
					Global.mana -= 6
					$Animation.play("heal")
			$RegenTime.start()
		
func _process(_delta):
	print(Global.player_current_attack)
	print($CollisionProjectileArea/CollisionProjectile.disabled)
	if Global.equip[0] != null:
		if Global.equip[0]["quantity"] != 0:
			$CanvasLayer/HBoxContainer/SkillBox1/Sprite2D.texture = load(Global.equip[0]["texture"])
			$CanvasLayer/HBoxContainer/SkillBox1/ColorRect/Label.text = str(Global.equip[0]["quantity"])
		elif Global.equip[0]["quantity"] == 0:
			Global.equip[0] = null
	
	elif Global.equip[0] == null:
		$CanvasLayer/HBoxContainer/SkillBox1/Sprite2D.texture = load("")
		$CanvasLayer/HBoxContainer/SkillBox1/ColorRect/Label.text = ""
	
	if Global.equip[1] != null:
		if Global.equip[1]["quantity"] != 0:
			$CanvasLayer/HBoxContainer/SkillBox2/Sprite2D.texture = load(Global.equip[1]["texture"])
			$CanvasLayer/HBoxContainer/SkillBox2/ColorRect/Label.text = str(Global.equip[1]["quantity"])
		elif Global.equip[1]["quantity"] == 0:
			Global.equip[1] = null
	
	elif Global.equip[1] == null:
		$CanvasLayer/HBoxContainer/SkillBox2/Sprite2D.texture = load("")
		$CanvasLayer/HBoxContainer/SkillBox2/ColorRect/Label.text = ""
	
	if Global.equip[2] != null:
		if Global.equip[2]["quantity"] != 0:
			$CanvasLayer/HBoxContainer/SkillBox3/Sprite2D.texture = load(Global.equip[2]["texture"])
			$CanvasLayer/HBoxContainer/SkillBox3/ColorRect/Label.text = str(Global.equip[2]["quantity"])
		elif Global.equip[2]["quantity"] == 0:
			Global.equip[2] = null
	
	elif Global.equip[2] == null:
		$CanvasLayer/HBoxContainer/SkillBox3/Sprite2D.texture = load("")
		$CanvasLayer/HBoxContainer/SkillBox3/ColorRect/Label.text = ""
		

func player_movement():
	var movement = Input.get_vector("Left", "Right", "Up", "Down")
	if velocity.x == 0 and velocity.y == 0:
		player_state = "idle"
	elif velocity.x != 0 or velocity.y != 0:
		player_state = "walk"
	
	if !attack_ip:
		if Input.is_action_pressed("Run"):
			velocity = movement * speed * 1.5
		else:
			velocity = movement * speed
		move_and_slide()
		play_anim(movement)
	
	if $CanvasLayer/GUI.visible:
		attack()

func play_anim(movement):
	var anim = $AnimatedSprite2D
	
	if player_state == "idle":
		if !attack_ip:
			if current_dir == "Walk_Back":
				anim.play("Idle_Back")
			if current_dir == "Walk_Front":
				anim.play("Idle_Front")
			if current_dir == "Walk_Side":
				anim.play("Idle_Side")
	elif player_state == "walk":
		if movement.y == -1:
			current_dir = "Walk_Back"
			anim.flip_h = false
			anim.play(current_dir)
		if movement.x == 1:
			current_dir = "Walk_Side"
			anim.flip_h = true
			anim.play(current_dir)
		if movement.y == 1:
			current_dir = "Walk_Front"
			anim.flip_h = true
			anim.play(current_dir)
		if movement.x == -1:
			current_dir = "Walk_Side"
			anim.flip_h = false
			anim.play(current_dir)
		
		if movement.x > 0.5 and movement.y < -0.5:
			current_dir = "Walk_Side"
			anim.flip_h = true
			anim.play(current_dir)
		if movement.x > 0.5 and movement.y > 0.5:
			current_dir = "Walk_Side"
			anim.flip_h = true
			anim.play(current_dir)
		if movement.x < -0.5 and movement.y > 0.5:
			current_dir = "Walk_Side"
			anim.flip_h = false
			anim.play(current_dir)
		if movement.x < -0.5 and movement.y < -0.5:
			current_dir = "Walk_Side"
			anim.flip_h = false
			anim.play(current_dir)

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		enemy = body
	if body.has_method("save_point"):
		save_state = true
	if body.has_method("character"):
		inDialogueBox = true
		character = body
		pos = 1

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		enemy = null
	if body.has_method("save_point"):
		save_state = false
	if body.has_method("character"):
		inDialogueBox = false
		character = null
		pos = 0

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		if enemy != null:
			$RegenTime.stop()
			Global.mana = Global.mana - (enemy.str/Global.def)
			if Global.mana <= 0:
				Global.health += Global.mana
				if Global.health <= 0:
					Global.health = 0
				Global.mana = 0
			enemy_attack_cooldown = false
			modulate.a8 = 100
			$DamageCooldown.start()
			$RegenTime.start()

func _on_attack_cooldown_timeout():
	modulate.a8 = 255
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	var anim = $AnimatedSprite2D
	var counter = $AttackCounter
	
	if !save_state:
		if Input.is_action_just_pressed("Attack-OK"):
			play_sfx("res://Assets/Music/swordStrike.wav")
			Global.player_current_attack = true
			attack_ip = true
			if dir == "Walk_Side":
				anim.play("Attack_Side")
			if dir == "Walk_Front":
				anim.play("Attack_Front")
			if dir == "Walk_Back":
				anim.play("Attack_Back")
			counter.start()


func _on_attack_counter_timeout():
	$AttackCounter.stop()
	Global.player_current_attack = false
	attack_ip = false
	
func current_camera():
	if Global.current_scene == "Dungeon1":
		$Camera.limit_left = get_parent().find_child("ReferenceRect").position.x
		$Camera.limit_top = get_parent().find_child("ReferenceRect").position.y
		$Camera.limit_right = get_parent().find_child("ReferenceRect").size.x + get_parent().find_child("ReferenceRect").position.x
		$Camera.limit_bottom = get_parent().find_child("ReferenceRect").size.y + get_parent().find_child("ReferenceRect").position.y
	
	elif Global.current_scene == "Dungeon2":
		$Camera.limit_right = 640
		$Camera.limit_bottom = 310
	
	elif Global.current_scene == "Dungeon3":
		$Camera.limit_right = 640
		$Camera.limit_bottom = 310
		
	elif Global.current_scene == "Dungeon4":
		$Camera.limit_right = 640
		$Camera.limit_bottom = 310
		
	elif Global.current_scene == "Dungeon5":
		$Camera.limit_right = 640
		$Camera.limit_bottom = 310
		
	elif Global.current_scene == "Dungeon6":
		$Camera.limit_right = 1408
		$Camera.limit_bottom = 1312
	
	elif Global.current_scene == "BossRoom" || Global.current_scene == "BossRoom1":
		$Camera.limit_right = 640
		$Camera.limit_bottom = 310
	
	elif Global.current_scene == "Dungeon7":
		$Camera.limit_right = 640
		$Camera.limit_bottom = 310

func update_health():
	var healthbar = $CanvasLayer/GUI/VBoxContainer/HPBar/Counter/TextureProgressBar
	var manabar = $CanvasLayer/GUI/VBoxContainer/MPBar/Counter/TextureProgressBar
	var healthCounter = $CanvasLayer/GUI/VBoxContainer/HPBar/Counter/Label
	var manaCounter = $CanvasLayer/GUI/VBoxContainer/MPBar/Counter/Label
	
	healthbar.max_value = Global.max_health
	healthbar.value = Global.health
	manabar.max_value = Global.max_mana
	manabar.value = Global.mana
	
	healthCounter.text = str(Global.health)+"/"+str(Global.max_health)
	manaCounter.text = str(Global.mana)+"/"+str(Global.max_mana)
	

func _on_regen_time_timeout():
	if Global.mana < Global.max_mana:
		Global.mana += 20
		if Global.mana >= Global.max_mana:
			Global.mana = Global.max_mana
		elif Global.mana <= 0:
			Global.mana = 0

func play_bgm():
	if !$BGM.playing:
		$BGM.play() 

func play_sfx(path):
	$SFX.stream = load(path)
	$SFX.play()

func transfer_exp(exp):
	Global.exp += exp
	if Global.exp >= Global.next:
		Global.level += 1
		if (Global.level % 2) == 0:
			Global.str += 5
			Global.max_health += 7
			Global.max_mana += 5
			Global.def += 3
			Global.next *= 5
		else:
			Global.str += 3
			Global.max_health += 9
			Global.max_mana += 6
			Global.def += 1
			Global.next *= 3
		$Animation.play("text_level_up")

func save():
	if save_state:
		if Input.is_action_just_pressed("Attack-OK"):
			Global.health = Global.max_health
			Global.mana = Global.max_mana
			Global.player_enter_posx = position.x
			Global.player_enter_posy = position.y
			Global.save_game()
			$Animation.play("text_saved")

func chat():
	if Input.is_action_just_pressed("OK Button"):
		if character.type == "teacher":
			Global.dialogueBox = true
			$"CanvasLayer/Dialogue Box".visible = true
			if pos == 1:
				Engine.time_scale = 0
				$"CanvasLayer/Dialogue Box/Name".text = "Guru"
				$"CanvasLayer/Dialogue Box/Text".text = "Mau beli apa? Aku akan membantumu sebisaku."
			if pos == 2:
				$CanvasLayer/TeacherInventory.inventory[0] = {
					"quantity": 1,
					"type": "Consumables",
					"name": "Potion",
					"texture": "res://Assets/Potion.png",
					"effect": "+30 HP",
					"price": 20,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[1] = {
					"quantity": 1,
					"type": "Skill",
					"name": "Lightning Bolt",
					"texture": "res://Assets/lightning.png",
					"effect": "Lightning Damage",
					"price": 50,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[2] = {
					"quantity": 1,
					"type": "Skill",
					"name": "Fire Ring",
					"texture": "res://Assets/FireRing.png",
					"effect": "Explosive Damage",
					"price": 50,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[3] = {
					"quantity": 1,
					"type": "Consumables",
					"name": "Tonic",
					"texture": "res://Assets/Tonic.png",
					"effect": "+50 MP",
					"price": 30,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[4] = {
					"quantity": 1,
					"type": "Consumables",
					"name": "Mega Potion",
					"texture": "res://Assets/Mega Potion.png",
					"effect": "+150 HP",
					"price": 100,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[5] = {
					"quantity": 1,
					"type": "Consumables",
					"name": "Mega Tonic",
					"texture": "res://Assets/Mega Tonic.png",
					"effect": "+200 MP",
					"price": 120,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[6] = {
					"quantity": 1,
					"type": "Consumables",
					"name": "STR Boost",
					"texture": "res://Assets/STR Boost.png",
					"effect": "Attack +20",
					"price": 1000,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[7] = {
					"quantity": 1,
					"type": "Skill",
					"name": "Fire Breath",
					"texture": "res://Assets/Fire Breath.png",
					"effect": "Fire Breath",
					"price": 50,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[8] = {
					"quantity": 1,
					"type": "Skill",
					"name": "Ice Glacier",
					"texture": "res://Assets/Ice Glacier.png",
					"effect": "Unleash Glacier",
					"price": 500,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.inventory[9] = {
					"quantity": 1,
					"type": "Skill",
					"name": "Heal",
					"texture": "res://Assets/Heal.png",
					"effect": "Heal HP",
					"price": 150,
					"scene_path": "res://Scene/Dungeon1.tscn"
				}
				
				$CanvasLayer/TeacherInventory.visible = true
			if pos >= 3:
				Engine.time_scale = 1
				pos = 0
				Global.dialogueBox = false
				$CanvasLayer/TeacherInventory.visible = false
				$"CanvasLayer/Dialogue Box".visible = false
		if character.type == "sign":
			if character.text == 1:
				Global.dialogueBox = true
				$"CanvasLayer/Dialogue Box".visible = true
				Engine.time_scale = 0
				if pos == 1:
					$"CanvasLayer/Dialogue Box/Name".text = "Papan Tutorial"
					$"CanvasLayer/Dialogue Box/Text".text = "WASD dan Arrow Key untuk jalan, Spasi dan Enter untuk menyerang"
				if pos == 2:
					$"CanvasLayer/Dialogue Box/Name".text = "Papan Tutorial"
					$"CanvasLayer/Dialogue Box/Text".text = "Tekan Shift dan berjalan untuk lari"
				if pos == 3:
					Engine.time_scale = 1
					pos = 0
					Global.dialogueBox = false
					$"CanvasLayer/Dialogue Box".visible = false
			if character.text == 2:
				Global.dialogueBox = true
				$"CanvasLayer/Dialogue Box".visible = true
				Engine.time_scale = 0
				if pos == 1:
					$"CanvasLayer/Dialogue Box/Name".text = "Hint"
					$"CanvasLayer/Dialogue Box/Text".text = "Untuk membuka pintu, pergi ke tengkorak."
				if pos == 2:
					$"CanvasLayer/Dialogue Box/Name".text = "Hint"
					$"CanvasLayer/Dialogue Box/Text".text = "Pergi ke selatan 3 petak."
				if pos == 3:
					$"CanvasLayer/Dialogue Box/Name".text = "Hint"
					$"CanvasLayer/Dialogue Box/Text".text = "Pergi ke barat 1 petak."
				if pos == 4:
					$"CanvasLayer/Dialogue Box/Name".text = "Hint"
					$"CanvasLayer/Dialogue Box/Text".text = "Pergi ke selatan 4 petak."
				if pos == 5:
					$"CanvasLayer/Dialogue Box/Name".text = "Hint"
					$"CanvasLayer/Dialogue Box/Text".text = "Pergi ke barat 5 petak."
				if pos == 6:
					$"CanvasLayer/Dialogue Box/Name".text = "Hint"
					$"CanvasLayer/Dialogue Box/Text".text = "Pergi ke utara 6 petak."
				if pos == 7:
					Engine.time_scale = 1
					pos = 0
					Global.dialogueBox = false
					$"CanvasLayer/Dialogue Box".visible = false
			if character.text == 3:
				if !Global.open2:
					Global.dialogueBox = true
					$"CanvasLayer/Dialogue Box".visible = true
					Engine.time_scale = 0
					if pos == 1:
						$"CanvasLayer/Dialogue Box/Name".text = ""
						$"CanvasLayer/Dialogue Box/Text".text = "Kamu menekan sebuah tombol."
					if pos == 2:
						Engine.time_scale = 1
						pos = 0
						Global.dialogueBox = false
						Global.open2 = true
						$"CanvasLayer/Dialogue Box".visible = false
			if character.text == 4:
				Global.dialogueBox = true
				$"CanvasLayer/Dialogue Box".visible = true
				Engine.time_scale = 0
				if pos == 1:
					$"CanvasLayer/Dialogue Box/Name".text = "Hint"
					$"CanvasLayer/Dialogue Box/Text".text = "Tekan 4 tombol di pojokan untuk membuka pintu."
				if pos == 2:
					Engine.time_scale = 1
					pos = 0
					Global.dialogueBox = false
					Global.open2 = true
					$"CanvasLayer/Dialogue Box".visible = false
			if character.text == 5:
				Global.dialogueBox = true
				$"CanvasLayer/Dialogue Box".visible = true
				Engine.time_scale = 0
				if pos == 1:
					$"CanvasLayer/Dialogue Box/Name".text = "Papan Tutorial"
					$"CanvasLayer/Dialogue Box/Text".text = "Tekan Enter atau Spasi untuk menyimpan data."
				if pos == 2:
					Engine.time_scale = 1
					pos = 0
					Global.dialogueBox = false
					Global.open2 = true
					$"CanvasLayer/Dialogue Box".visible = false
		pos += 1

func _on_animation_animation_finished(anim_name):
	Global.paused = true

func apply_item_effect(item):
	match item["effect"]:
		"+30 HP":
			Global.health += 30
			if Global.health > Global.max_health:
				Global.health = Global.max_health
		"+50 MP":
			Global.mana += 50
			if Global.mana > Global.max_mana:
				Global.mana = Global.max_mana
		"+150 HP":
			Global.health += 150
			if Global.health > Global.max_health:
				Global.health = Global.max_health
		"+200 MP":
			Global.mana += 200
			if Global.mana > Global.max_mana:
				Global.mana = Global.max_mana
		"Attack +20":
			Global.str += 20

func _on_collision_projectile_area_body_entered(body):
	if body.has_method("enemy"):
		if !$CollisionProjectileArea/CollisionProjectile.disabled:
			if Global.equip[Global.skill]["effect"] == "Lightning Damage":
				$Animation.stop()
				$CollisionProjectileArea/CollisionProjectile.disabled = true
				$Projectile.visible = false
			if Global.equip != null:
				body.player_inattack_zone = true
				Global.player_current_attack = true
				body.deal_with_damage()
				body.player_inattack_zone = false
				Global.player_current_attack = false

func _radius10():
	$CollisionProjectileArea/CollisionProjectile.shape.set_radius(10)

func _radius25():
	$CollisionProjectileArea/CollisionProjectile.shape.set_radius(25)

func _heal_player():
	Global.health += (Global.str + Global.equip[Global.skill]["quantity"])
	if Global.health > Global.max_health:
		Global.health = Global.max_health
