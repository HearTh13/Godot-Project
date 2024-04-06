extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var sprite = $Sprite2D
@onready var healthbar = $UI/TextureRect/TextureProgressBar
@onready var healthbar_with_image = $UI/TextureRect

var direction: Vector2

var max_health = 200
var health = max_health
var speed = 60
var str = 250
var def = 4
var exp = 200

var player_inattack_zone = false
var take_damage = false

var alive = true

func enemy():
	pass

func _ready():
	set_physics_process(false)
	$Debug.visible = false

func _process(_delta):
	direction = player.position - position
	
	if !$Collision.disabled:
		if direction.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	
	deal_with_damage()
	update_health()
		
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func update_health():
	healthbar.value = health
	healthbar.max_value = max_health
	
	if health <= 0:
		healthbar_with_image.visible = false
		find_child("FiniteStateMachine").change_state("Death")
		$Collision.disabled = true
	elif health <= max_health / 2 and def == 4:
		health = max_health / 2
		def += 6
		find_child("FiniteStateMachine").change_state("ArmorBuff")

func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack:
		if !take_damage:
			if player != null:
				health = health - (Global.str/def)
				$DamageCooldown.start()
				take_damage = true
				modulate.a8 = 100
				play_sfx()

func play_sfx():
	$SFX.play()

func _on_damage_cooldown_timeout():
	modulate.a8 = 255
	take_damage = false

func player_take_damage():
	if player.enemy_attack_cooldown:
		print("damage")
		Global.health = Global.health - (str/Global.def)
		player.enemy_attack_cooldown = false
		player.modulate.a8 = 100
		player.find_child("DamageCooldown").start()

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player.enemy_attack_cooldown = true
		player_take_damage()
