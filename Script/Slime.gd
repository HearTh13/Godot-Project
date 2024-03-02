extends CharacterBody2D

var speed = 45
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("Walk")
		
		if(player.position.x - position.x):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		$AnimatedSprite2D.play("Idle")


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
		health -= 20
		print("slime health = ", health)
		if health <= 0:
			self.queue_free()
