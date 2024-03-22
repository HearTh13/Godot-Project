extends CharacterBody2D

var enemy = null
var signBoard = null
var floor = null
var character = null

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true

var current_dir = "Walk_Front"
var player_state = "idle"

const speed = 125

var attack_ip = false
var save_state = false
var signMessage = false
var inDialogueBox = false

var pos = 0

func _physics_process(_delta):
	play_bgm()
	if !Global.paused or !Global.dialogueBox:
		player_movement()
		enemy_attack()
		save()
		current_camera()
		update_health()
		mess()
	
		if Global.health <= 0:
			player_alive = false
			Global.health = 0
			print("player has been killed")
			self.queue_free()
	
	if inDialogueBox:
		chat()

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
	if body.has_method("board"):
		signMessage = true
		signBoard = body
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
	if body.has_method("board"):
		signMessage = false
		signBoard = null
	if body.has_method("character"):
		inDialogueBox = false
		character = null
		pos = 0

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		if enemy != null:
			Global.health = Global.health - (enemy.str/Global.def)
			enemy_attack_cooldown = false
			modulate.a8 = 100
			$DamageCooldown.start()

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
		$Camera.limit_right = 640
		$Camera.limit_bottom = 310
	
	elif Global.current_scene == "Dungeon2-1" or Global.current_scene == "Dungeon2-2":
		$Camera.limit_right = 640
		$Camera.limit_bottom = 310
	
	elif Global.current_scene == "Dungeon3":
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
	if Global.health < Global.max_health:
		Global.health += 20
		if Global.health >= Global.max_health:
			Global.health = Global.max_health
		elif Global.health <= 0:
			Global.health = 0

func play_bgm():
	if !$BGM.playing:
		$BGM.play() 

func play_sfx(path):
	$SFX.stream = load(path)
	$SFX.play()

func transfer_exp(exp):
	Global.exp += exp
	print(Global.exp)
	print(Global.next)
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
		print("Level up")

func save():
	if save_state:
		if Input.is_action_just_pressed("Attack-OK"):
			Global.player_enter_posx = position.x
			Global.player_enter_posy = position.y
			Global.save_game()
			print("Data saved")

func mess():
	if signMessage:
		if Input.is_action_just_pressed("Attack-OK"):
			Global.dialogue = 0
			Global.message = signBoard.text
			Global.player_enter_posx = position.x
			Global.player_enter_posy = position.y
			get_tree().change_scene_to_file("res://Interface/dialogue_gui.tscn")

func chat():
	if Input.is_action_just_pressed("Attack-OK"):
		Global.dialogueBox = true
		$"CanvasLayer/Dialogue Box".visible = true
		if character.type == "teacher":
			if pos == 1:
				Engine.time_scale = 0
				$"CanvasLayer/Dialogue Box/Name".text = "Guru"
				$"CanvasLayer/Dialogue Box/Text".text = "Duduk semuanya. Pelajaran akan dimulai!"
			if pos >= 2:
				Engine.time_scale = 1
				Global.dialogueBox = false
				$"CanvasLayer/Dialogue Box".visible = false
				pos = 0
		pos += 1
