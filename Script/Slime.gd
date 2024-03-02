extends CharacterBody2D

var player = null

var max_health = 100
var health = max_health
var speed = 45
var str = 20
var def = 2

var player_chase = false
var player_inattack_zone = false
var take_damage = false

func _physics_process(delta):
	deal_with_damage()
	update_health()
	
	if !take_damage:
		if player_chase:
			position += (player.position - position)/speed
			
			$AnimatedSprite2D.play("Walk")
			
			if(player.position.x - position.x):
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			
		else:
			var rng = RandomNumberGenerator.new()
			var my_random_number = rng.randi_range(0, 4)
			if my_random_number == 0:
				$AnimatedSprite2D.play("Walk")
				$AnimatedSprite2D.flip_h = false
				position.x -= (speed-100)/speed
			elif my_random_number == 1:
				$AnimatedSprite2D.play("Walk")
				$AnimatedSprite2D.flip_h = true
				position.x += (speed-100)/speed
			elif my_random_number == 2:
				$AnimatedSprite2D.play("Walk")
				$AnimatedSprite2D.flip_h = false
				position.y += (speed-100)/speed
			elif my_random_number == 3:
				$AnimatedSprite2D.play("Walk")
				$AnimatedSprite2D.flip_h = false
				position.y -= (speed-100)/speed
			else:
				$AnimatedSprite2D.play("Idle")
				$AnimatedSprite2D.flip_h = false
				position.x = 0
				position.y = 0
	else:
		$AnimatedSprite2D.play("Dead")
			


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack:
		if !take_damage:
			health -= player.str
			$DamageCooldown.start()
			take_damage = true
			print("slime health = ", health)
			if health <= 0:
				self.queue_free()

func _on_damage_cooldown_timeout():
	take_damage = false
	
func update_health():
	var healthbar = $Healthbar
	var damagebar = $Healthbar/Damagebar
	
	healthbar.value = health
	damagebar.value = health
	
	if health >= max_health:
		healthbar.visible = false
	else:
		healthbar.visible = true


