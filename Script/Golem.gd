extends CharacterBody2D

@export var limit = 0.5
@export var marker: Marker2D
@onready var animation = $Normal
@onready var attackAnim = $Attack

var player = null

var max_health = 200
var health = max_health
var speed = 60
var str = 40
var def = 4
var exp = 35

var alive = true
var running = true
var player_chase = false
var player_inattack_zone = false
var take_damage = false

var startPosition
var endPosition

var pos

func _ready():
	startPosition = position
	endPosition = marker.global_position

func _physics_process(delta):
	if !Global.paused or !Global.dialogueBox:
		deal_with_damage()
		update_health()
		
		if !take_damage:
			if player_chase:
				if running:
					velocity = (player.get_global_position() - position).normalized() * speed * delta
					if player.position.x < position.x:
						pos = "Walk_left"
					else:
						pos = "Walk_right"
					animation.play(pos)
				
				else:
					attack_scene()
			else:
				velocity = lerp(velocity, Vector2.ZERO, 0.07)
				animation.play("Idle")
			move_and_collide(velocity)
		else:
			animation.play("Dead")
			
func changeDir():
	var temp = endPosition
	endPosition = startPosition
	startPosition = temp

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDir()
	velocity = moveDirection.normalized() * speed

func spriteAnimation():
	pos = "Walk_left"
	if velocity.x > 0:
		pos = "Walk_right"
	animation.play(pos)
	
func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
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
			if player != null:
				health = health - Global.str
				$DamageCooldown.start()
				$Run.start()
				print(running)
				running = false
				print(running)
				take_damage = true
				modulate.a8 = 100
				play_sfx()
				if health <= 0:
					player.transfer_exp(exp)
					$Dead.start()

func _on_damage_cooldown_timeout():
	modulate.a8 = 255
	take_damage = false
	
func update_health():
	var healthbar = $Healthbar
	var damagebar = $Healthbar/Damagebar
	
	healthbar.value = health
	healthbar.max_value = max_health
	damagebar.value = health
	damagebar.max_value = max_health
	
	if health >= max_health:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_run_timeout():
	animation.visible = true
	attackAnim.visible = false
	running = true

func play_sfx():
	$SFX.play()

func _on_dead_timeout():
	self.queue_free()


func _on_attack_area_body_entered(body):
	if body.has_method("player"):
		velocity = Vector2(0, 0)
		running = false
		$AttackAnimation.start()

func _on_attack_area_body_exited(body):
	if body.has_method("player"):
		animation.visible = false
		attackAnim.visible = true
		running = true

func attack_scene():
	animation.visible = false
	attackAnim.visible = true
	var playerPos = player.position
	if pos == "Walk_left":
		attackAnim.play("Attack_Left")
	elif pos == "Walk_right":
		attackAnim.play("Attack_Right")
	

func _on_attack_animation_timeout():
	animation.visible = true
	attackAnim.visible = false
	running = true
