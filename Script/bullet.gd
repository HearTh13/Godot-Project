extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_parent().find_child("Player")

var acceleration: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
	acceleration = (player.position - position).normalized() * 700
	
	velocity += acceleration * delta
	rotation = velocity.angle()
	
	velocity = velocity.limit_length(150)
	
	position += velocity * delta


func _on_body_entered(body):
	if body.has_method("player"):
		Global.health -= (get_parent().find_child("GolemBoss").str/Global.def)
		player.enemy_attack_cooldown = false
		player.modulate.a8 = 100
		player.find_child("DamageCooldown").start()
	queue_free()

func _on_free_timeout():
	queue_free()
