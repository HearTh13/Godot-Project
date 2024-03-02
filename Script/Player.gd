extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 160
var player_alive = true

const speed = 125
var current_dir = "none"

var attack_ip = false

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	current_camera()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("player has been killed")
		self.queue_free()

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		if Input.is_action_pressed("Run"):
			velocity.x = speed*2
		else:
			velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		if Input.is_action_pressed("Run"):
			velocity.x = -(speed*2)
		else:
			velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		if Input.is_action_pressed("Run"):
			velocity.y = -(speed*2)
		else:
			velocity.y = -speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		if Input.is_action_pressed("Run"):
			velocity.y = speed*2
		else:
			velocity.y = speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = true
		if movement == 1:
			anim.play("Walk_Side")
		elif movement == 0:
			if !attack_ip:
				anim.play("Idle_Side")
			
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Side")
		elif movement == 0:
			if !attack_ip:
				anim.play("Idle_Side")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Back")
		elif movement == 0:
			if !attack_ip:
				anim.play("Idle_Back")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Front")
		elif movement == 0:
			if !attack_ip:
				anim.play("Idle_Front")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		health -= 20
		enemy_attack_cooldown = false
		$DamageCooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	var anim = $AnimatedSprite2D
	var counter = $AttackCounter
	
	if Input.is_action_just_pressed("Attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			anim.flip_h = true
			anim.play("Attack_Side")
			counter.start()
		if dir == "left":
			anim.flip_h = false
			anim.play("Attack_Side")
			counter.start()
		if dir == "down":
			anim.flip_h = false
			anim.play("Attack_Front")
			counter.start()
		if dir == "up":
			anim.flip_h = false
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
