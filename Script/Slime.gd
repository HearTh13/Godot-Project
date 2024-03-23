extends CharacterBody2D

@export var limit = 0.5
@export var marker: Marker2D
@onready var animation = $AnimatedSprite2D

var player = null

var max_health = 100
var health = max_health
var speed = 35
var str = 20
var def = 2
var exp = 5

var alive = true
var running = true
var player_chase = false
var player_inattack_zone = false
var take_damage = false

var startPosition
var endPosition

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
				
				$AnimatedSprite2D.play("Walk")
				
				if player.position.x < position.x :
					$AnimatedSprite2D.flip_h = false
				else:
					$AnimatedSprite2D.flip_h = true
				move_and_collide(velocity)
			else:
				updateVelocity()
				move_and_slide()
				spriteAnimation()
		else:
			$AnimatedSprite2D.play("Dead")
			
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
	animation.flip_h = false
	if velocity.x > 0:
		animation.flip_h = true

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
			if player != null:
				health = health - Global.str
				$DamageCooldown.start()
				$Run.start()
				running = false
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
	running = true
	

func play_sfx():
	$SFX.play()

func _on_dead_timeout():
	self.queue_free()
