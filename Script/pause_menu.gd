extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Objective/Label.text = Global.objective
