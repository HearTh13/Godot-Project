extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

const speed = 125
var current_dir = "none"

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
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
			anim.play("Idle_Side")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Side")
		elif movement == 0:
			anim.play("Idle_Side")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Back")
		elif movement == 0:
			anim.play("Idle_Back")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("Walk_Front")
		elif movement == 0:
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
	pass
