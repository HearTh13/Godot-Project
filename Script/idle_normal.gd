extends State

@onready var collision = $"../../PlayerDetection/Collision"
@onready var progress_bar = $"../../Healthbar"

var startPosition
var endPosition

var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)
		progress_bar.set_deferred("visible", value)

func transition():
	if player_entered:
		get_parent().change_state("Follow")

func _on_player_detection_body_entered(body):
	if body.has_method("player"):
		player_entered = true
