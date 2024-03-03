extends CharacterBody2D

@export var inv: Inv

var enemy = null

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var max_health = 160
var health = max_health
var player_alive = true
var str = 20
var def = 10
const speed = 125
var current_dir = "none"
var player_state = "none"

var attack_ip = false

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	current_camera()
	update_health()
	
	if health <= 0:
		player_alive = false
		health = 0
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
	enemy = body
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	enemy = null
	if body.has_method("enemy"):
		enemy_inattack_range = false
		

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		health -= enemy.str
		enemy_attack_cooldown = false
		$DamageCooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
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
	var healthbar = $Healthbar
	var damagebar = $Healthbar/Damagebar
	
	healthbar.value = health
	damagebar.value = health
	
	if health >= max_health:
		healthbar.visible = false
		damagebar.visible = false
	else:
		healthbar.visible = true
		damagebar.visible = true

func _on_regen_time_timeout():
	if health < max_health:
		health += 20
		if health >= max_health:
			health = max_health
		elif health <= 0:
			health = 0
