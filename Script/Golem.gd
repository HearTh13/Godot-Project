extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var sprite = $Normal
@onready var attackSprite = $Attack
@onready var healthbar = $Healthbar

var direction: Vector2

var player_inattack_zone = false
var take_damage = false

var max_health = 150
var health = max_health
var speed = 35
var str = 60
var def = 3
var exp = 40

func player_take_damage():
	if player.enemy_attack_cooldown:
		print("damage")
		Global.health = Global.health - (str/Global.def)
		player.enemy_attack_cooldown = false
		player.modulate.a8 = 100
		player.find_child("DamageCooldown").start()

func death():
	queue_free()

func enemy():
	pass

func _ready():
	set_physics_process(false)

func _process(_delta):
	direction = player.position - position
	
	if !$Collision.disabled:
		if player.position.x < position.x:
			sprite.flip_h = false
			attackSprite.flip_h = false
		else:
			sprite.flip_h = true
			attackSprite.flip_h = true
	
	deal_with_damage()
	update_health()
		
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func update_health():
	healthbar.value = health
	healthbar.max_value = max_health
	
	if health <= 0:
		healthbar.visible = false
		find_child("FiniteStateMachine").change_state("Death")
		$Collision.disabled = true

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
