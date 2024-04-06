extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("walk")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var distance = owner.direction.length()
	
	if distance < 30:
		owner.player_inattack_zone = true
		get_parent().change_state("MeleeAttack")
	else:
		owner.player_inattack_zone = false
