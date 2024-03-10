extends CharacterBody2D

var enemy = null

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true

var current_dir = "none"
var player_state = "none"

const speed = 125

var attack_ip = false

func _physics_process(delta):
	if !Global.paused:
		player_movement(delta)
		enemy_attack()
		current_camera()
		update_health()
	
		if Global.health <= 0:
			player_alive = false
			Global.health = 0
			print("player has been killed")
			self.queue_free()

func player_movement(delta):
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
	
	attack()

func play_anim(movement):
	var dir = current_dir
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

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		enemy = null
		

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		if enemy != null:
			Global.health -= enemy.str
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
	
	if Input.is_action_just_pressed("Attack-OK"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == "Walk_Side":
			anim.play("Attack_Side")
			counter.start()
		if dir == "Walk_Front":
			anim.play("Attack_Front")
			counter.start()
		if dir == "Walk_Back":
			anim.play("Attack_Back")
			counter.start()


func _on_attack_counter_timeout():
	$AttackCounter.stop()
	Global.player_current_attack = false
	attack_ip = false
	
func current_camera():
	if Global.current_scene == "Dungeon1":
		$Dungeon1Camera.enabled = true
		$Dungeon2Camera.enabled = false
	
	elif Global.current_scene == "Dungeon2":
		$Dungeon1Camera.enabled = false
		$Dungeon2Camera.enabled = true

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

